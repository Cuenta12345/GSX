#!/bin/bash

# Verificar si la imagen 'prac3' no existe
if ! docker images | grep 'prac5' ; then
    read -p "No existe la imagen para la práctica 5. ¿Desea crearla? [y/n]: " decision
    if [ "$decision" == 'y' ]; then
        # Coloca aquí el código para crear la imagen 'prac3'
        echo "Creando la imagen para la práctica 5..."
        docker build -t gsx:prac5 -f /home/milax/GSX/Redes/docker/dockerfile_gsx_prac5 .
        docker images
    else
        echo "Saliendo del programa..."
        exit 0
    fi

    echo -e "Creando Red para entorno..."
    if ! docker network ls | grep 'ISP'; then
        docker network create --driver=bridge --subnet=10.0.2.16/30 ISP
    fi
    if ! docker network ls | grep 'DMZ'; then
        docker network create --driver=bridge --subnet=198.18.248.0/23 --gateway=198.18.248.2 DMZ
    fi
    if ! docker network la | grep 'INTRANET'; then
        docker network create --driver=bridge --subnet=172.24.248.80/28 --gateway=172.24.248.82 INTRANET
    fi    

    docker network ls

    echo -e "Creando contenedores de para el entorno...\n"
    contenedores=('Router' 'Server' 'Client1')
    contenedoresAux=('router' 'server' 'client1')

    echo -e "Contenedores a crear\n"
    for contenedor in "${contenedores[@]}"; do
        echo "$contenedor\n"
    done

    imatge="gsx:prac5"

    for ((i=0; i<${#contenedores[@]}; i++)); do
        contenedor="${contenedores[i]}"
        contenedorAux="${contenedoresAux[i]}"
        
        if ! docker container ls -a | grep "$contenedor"; then
            if [ "$contenedor" == 'Server' ]; then 
                docker run -itd --rm --privileged --mount type=bind,src=/home/milax/GSX/Redes/docker/practica5,dst=/root/prac5 --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --hostname "$contenedorAux" --network=DMZ --name "$contenedor" "$imatge"
            elif [ "$contenedor" == 'Router' ]; then
                docker run -itd --rm --privileged --mount type=bind,src=/home/milax/GSX/Redes/docker/practica5,dst=/root/prac5,readonly --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --hostname "$contenedorAux" --network=ISP --name "$contenedor" "$imatge"
                docker network connect DMZ "$contenedor"
                docker network connect INTRANET "$contenedor"
            else
                docker run -itd --rm --privileged --mount type=bind,src=/home/milax/GSX/Redes/docker/practica5,dst=/root/prac5,readonly --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --hostname "$contenedorAux" --network=INTRANET --name "$contenedor" "$imatge"
            fi
        fi
    done


    echo -e "Contenedores activos\:"
    docker container ls -a
fi