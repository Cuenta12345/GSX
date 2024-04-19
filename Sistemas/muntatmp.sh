#!/bin/bash

# Se comprueba si se está ejecutando como root
if [ "$EUID" -ne 0 ]; then
    echo "Este script requiere privilegios de superusuario para ejecutarse."
    exit 1
fi

# Se crea una carpeta donde se montará el nuevo sistema de archivos
mkdir /empresaDisk
chmod 755 /empresaDisk
chown :users /empresaDisk

# Se formatea el disco
blkid /dev/sdb

# Se crea un sistema de archivos ext4
mkfs.ext4 /dev/sdb

# Se monta el nuevo disco en el directorio raíz
mount /dev/sdb /empresaDisk

# Se mueve el directorio /empresa al nuevo punto de montaje
if [ -d /empresaDisk ]; then
    echo "Copiando el directorio de la empresa al nuevo disco"
    cp -r /empresa /empresaDisk
else
    echo "No existe directorio de empresa que copiar, SALIENDO"
    exit 1
fi

# Se crea un script para montar el sistema de archivos cuando un usuario inicie sesión
echo '/dev/sdb    /empresaDisk    ext4    noauto,rw,user,exec,umask=077,uid=root,gid=users    0 0' >> /etc/fstab