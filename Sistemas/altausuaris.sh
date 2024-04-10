#! /bin/bash

if [ $# -eq 2 ]; then 
	echo -e "Se han recibido los ficheros\n"
	echo -e "Recuperación de datos de usuarios del fichero [fitxer_prova_usuaris]"
	tail -n +2 "$1" | while IFS= read -r linea; do
    		dnis=$(echo "$linea" | awk -F ":" '{print $1}')
	        apellidos=$(echo "$linea" | awk -F ":" '{print $2}' | awk -F "," '{print $1}')
        	nombres=$(echo "$linea" | awk -F ":" '{print $2}' | awk -F "," '{sub(/^ */, "", $2); print $2}')
        	telefonos=$(echo "$linea" | awk -F ":" '{print $3}')
        	proyectos=$(echo "$linea" | awk -F ":" '{print $4}')

        	echo -e "\nDNIs: $dnis"
        	echo -e "\napellidos: $apellidos"
        	echo -e "\nnombres: $nombres"
        	echo -e "\ntelefonos: $telefonos"
        	echo -e "\nproyectos: $proyectos"
                echo -e "\n----------------------------------------------------------------\n"
	done

	echo -e "________________________________________________________________________________"
	echo -e "Recuperación de datos de proyectos del fichero [fitxer_prova_projectes]"
        tail -n +2 "$2" | while IFS= read -r linea; do
		proyectos=$(echo "$linea" | awk -F ":" '{print $1}' | awk -F "," '{sub(/^ */, "", $1); print $1}')
                jefes=$(echo "$linea" | awk -F ":" '{print $2}' | awk -F "," '{sub(/^ */, "", $1); print $1}')
                descripciones=$(echo "$linea" | awk -F ":" '{print $3}' | awk -F "," '{sub(/^ */, "", $1); print $1}')

	        echo -e "\nNombres de proyectos: $proyectos"
       		echo -e "\nJefes de proyectos: $jefes"
        	echo -e "\nDescripciones de proyectos: $descripciones"
		echo -e "\n----------------------------------------------------------------\n"
	done
	proyectos=$(cat fitxer_prova_projectes | tail -n +2 | awk -F ":" '{print $1}' | awk -F "," '{sub(/^ */, "", $1); print $1}')
	caps=$(cat fitxer_prova_projectes | tail -n +2 | awk -F ":" '{print $2}' | awk -F "," '{sub(/^ */, "", $1); print $1}')
	descripciones=$(cat fitxer_prova_projectes | tail -n +2 | awk -F ":" '{print $3}' | awk -F "," '{sub(/^ */, "", $1); print $1}')

#	echo -e "\nNombres de proyectos: \n$proyectos\n"
#        echo -e "\nJefes de proyectos: \n$caps\n"
#        echo -e "\nDescripciones de proyectos: \n$descripciones\n"

else
	echo "No se ha recibido nada"
fi
