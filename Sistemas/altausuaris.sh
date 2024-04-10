#! /bin/bash
#Comentario de prueba

if [ "$EUID" -ne 0 ]; then
	echo "Este script requiere privilegios de superusuario para ejecutarse."
	exit 1
fi

if [ $# -eq 2 ]; then 
	echo -e "Se han recibido los ficheros\n"
	echo -e "Recuperación de datos de usuarios del fichero [fitxer_prova_usuaris]"
	tail -n +2 "$1" | while IFS= read -r linea; do
    		dnis=$(echo "$linea" | awk -F ":" '{print $1}')
	        apellidos=$(echo "$linea" | awk -F ":" '{print $2}' | awk -F "," '{print $1}')
        	nombres=$(echo "$linea" | awk -F ":" '{print $2}' | awk -F "," '{sub(/^ */, "", $2); print $2}')
        	telefonos=$(echo "$linea" | awk -F ":" '{print $3}')
        	proyectos=$(echo "$linea" | awk -F ":" '{print $4}')
		
		apellido_aux=$(echo "$apellidos" | sed 's/ /_/g')

		if id "$apellidos_aux" >/dev/null 2>&1; then
    			echo "El usuario $apellidos ya existe."
		else
    			echo "El usuario $nombres $apellidos no existe. Creando..."
    			echo "$apellido_aux"
    			sudo adduser --disabled-password --gecos "" "$apellido_aux"
    			echo "$apellido_aux:$dnis" | sudo chpasswd
    			echo "El usuario $apellido_aux ha sido creado."
		fi

		for proyecto in $(echo "$proyectos" | tr ',' ' '); do
			if ! grep -q "^nombre_del_grupo:" /etc/group; then
				#echo "El grupo nombre_del_grupo no existe."
				#echo "Creando el grupo $proyecto"
				groupadd "$proyecto"
			fi
			 
		done
        	#echo -e "\nDNIs: $dnis"
        	#echo -e "\napellidos: $apellidos"
        	#echo -e "\nnombres: $nombres"
	       	#echo -e "\ntelefonos: $telefonos"
        	#echo -e "\nproyectos: $proyectos"
                #echo -e "\n----------------------------------------------------------------\n"
	done

	echo -e "________________________________________________________________________________"
	echo -e "Recuperación de datos de proyectos del fichero [fitxer_prova_projectes]"
        tail -n +2 "$2" | while IFS= read -r linea; do
		proyectos=$(echo "$linea" | awk -F ":" '{print $1}' | awk -F "," '{sub(/^ */, "", $1); print $1}')
                jefes=$(echo "$linea" | awk -F ":" '{print $2}' | awk -F "," '{sub(/^ */, "", $1); print $1}')
                descripciones=$(echo "$linea" | awk -F ":" '{print $3}' | awk -F "," '{sub(/^ */, "", $1); print $1}')

	        #echo -e "\nNombres de proyectos: $proyectos"
       		#echo -e "\nJefes de proyectos: $jefes"
        	#echo -e "\nDescripciones de proyectos: $descripciones"
		#echo -e "\n----------------------------------------------------------------\n"
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
