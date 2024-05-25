#!/bin/bash

if ! docker images | grep 'prac7' ; then
    read -p "No existe la imagen para la práctica 7. ¿Desea crearla? [y/n]: " decision
    if [ "$decision" == 'y' ]; then
        echo "Creando la imagen para la práctica 7..."
        docker build -t gsx:prac7 -f /home/milax/GSX/Redes/practica7/dockerfile_gsx_prac7 .
        docker images
    else
        echo "Saliendo del programa..."
        exit 0
    fi
fi

echo -e "Creando contenedores de para el entorno...\n"
imatge="gsx:prac7"
node=1
while [ $node -le 4 ]; do
	if [ $node -eq 1 ]; then
		docker run -itd --rm --privileged --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --hostname "$contenedorR$node" --name "R$node" "$imatge"
	else
		docker run -itd --rm --privileged --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --hostname "$contenedorR$node" --network=none --name "R$node" "$imatge"

	fi
	((node++))
done
    echo -e "Contenedores activos\:"
    docker container ls

echo -e "ATENCION\nA continaución se requiere el uso de superusuario para crear los enlaces\n"
sleep 5
echo -e "A continuación se comprobará si es superusuario, en caso de no serlo, ejecute de nuevo el programa"
sleep 5

sudo ./crear_enllaços_prac7.sh
echo -e "\nEnlaces creados con exito\nA continuación se ejecutara la configuración de cada uno de los contenedores\n"
node=1
while [ $node -le 4 ]; do
	docker exec R$node /root/prac7_config_rip.sh
	((node++))
done
