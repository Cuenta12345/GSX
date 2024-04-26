#!/bin/bash

# Verificar si la imagen 'prac3' no existe
if ! docker images | grep 'prac3' ; then
    read -p "No existe la imagen para la práctica 3. ¿Desea crearla? [y/n]: " decision
    if [ "$decision" == 'y' ]; then
        # Coloca aquí el código para crear la imagen 'prac3'
        echo "Creando la imagen para la práctica 3..."
        docker build -t gsx:prac3 -f /home/milax/GSX/Redes/docker/dockerfile_gsx_prac3 .
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

    echo -e "Creando contenedores de para el entorno...\n"
    contenedores=('Router' 'Sever' 'DHCP' 'Client1' 'Client2')
    contenedoresAux=('router' 'sever' 'dgcp' 'client1' 'client2')
    
    echo -e "Contenedores a crear\n"
    for contenedor in "${contenedores[@]}"; do
        echo "$contenedor\n"
    done

    OPCIONS="-it --rm --cap-add=NET_ADMIN --cap-add=SYS_ADMIN"
    imatge="gsx:prac3"


    for contenedor in "${contenedores[@]}"; do

        if ! docker container ls -a | grep "$contenedor"; then
            if [ $contenedor == 'Router' ]; then
                docker run -itd --rm --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --hostname "$contenedoresAux" --network=ISP --name "$contenedor" $imatge
                docker network connect DMZ Router
                docker network connect INTRANET Router
            else
                docker run $OPCIONS --hostname "$contenedoresAux" --network=ISP --name "$contenedor" $imatge
                if [ $contenedor == 'Server' ]; then 
                    docker network connect DMZ "$contenedor" 
                else
                    docker network connect INTRANET "$contenedor" 
                fi
            fi
        fi
    done
fi