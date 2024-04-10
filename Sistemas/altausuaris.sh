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

	echo -e "Recuperación de datos de proyectos del fichero [fitxer_prova_projectes]"
	proyectos=$(cat fitxer_prova_projectes | tail -n +2 | awk -F ":" '{print $1}' | awk -F "," '{sub(/^ */, "", $1); print $1}')
	caps=$(cat fitxer_prova_projectes | tail -n +2 | awk -F ":" '{print $2}' | awk -F "," '{sub(/^ */, "", $1); print $1}')
	descripciones=$(cat fitxer_prova_projectes | tail -n +2 | awk -F ":" '{print $3}' | awk -F "," '{sub(/^ */, "", $1); print $1}')

	echo -e "\nNombres de proyectos: \n$proyectos\n"
        echo -e "\nJefes de proyectos: \n$caps\n"
        echo -e "\nDescripciones de proyectos: \n$descripciones\n"

else
	echo "No se ha recibido nada"
fi
