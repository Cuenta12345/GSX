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
