#! /bin/bash

#Primero se comprueba que seamos root para poder ejecutarlo
if [ "$EUID" -ne 0 ]; then
	echo "Este script requiere privilegios de superusuario para ejecutarse."
	exit 1
fi

#Formateamos el disco
blkid /dev/sdb
#Creamos un sistema de ficheros
mkfs.ext4 /dev/sdb
#Montamos el nuevo disco en el directorio raíz
mount /dev/sdb /mnt/empresaDisk
