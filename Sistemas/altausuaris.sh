#! /bin/bash

if [ $# -eq 2 ]; then 
	echo -e "Se han recibido los ficheros\n"

	#Se guardan los dni's
	echo -e "Recuperación de datos de usuarios del fichero [fitxer_prova_usuaris]"
	dnis=$(cat fitxer_prova_usuaris | tail -n +2 | awk -F ":" '{print $1}')
	apellidos=$(cat fitxer_prova_usuaris | tail -n +2 | awk -F ":" '{print $2}' | awk -F "," '{print $1}')
	nombres=$(cat fitxer_prova_usuaris | tail -n +2 | awk -F ":" '{print $2}' | awk -F "," '{sub(/^ */, "", $1); print $1}')
	telefonos=$(cat fitxer_prova_usuaris | tail -n +2 | awk -F ":" '{print $3}')
	proyectos=$(cat fitxer_prova_usuaris | tail -n +2 | awk -F ":" '{print $4}')

	echo -e "\nDNIs: $dnis\n"
        echo -e "\napellidos: $apellidos\n"
        echo -e "\nnombres: $nombres\n"
        echo -e "\ntelefonos: $telefonos\n"
        echo -e "\nproyectos: $proyectos\n"


else
	echo "No se ha recibido nada"
fi
