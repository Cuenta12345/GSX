#!/bin/bash

# Comprobar si se han proporcionado los parámetros necesarios
if [ $# -eq 0 ]; then
    echo "Por favor, proporciona al menos una comanda como parámetro."
    exit 1
fi

comanda=$1
usuari=$2

if [ ! -z $2 ]; then
    # Si no se ha proporcionado un usuario, mostrar todos los usuarios que han ejecutado la comanda
    echo "Usuarios que han ejecutado la comanda '$comanda':"
    sudo lastcomm "$comanda" --user "$usuari" | awk '{print  $5, $6, $7, $8, $9}' | sort | uniq -c | grep -v "pts"
else
    # Si se ha proporcionado un usuario, mostrar los días en que el usuario ha ejecutado la comanda
    result=$(sudo lastcomm "$comanda" | sort | uniq -c)
    echo "Estos usuarios han ejecutado la comanda: $comanda"
    echo "$result"
    	

fi
