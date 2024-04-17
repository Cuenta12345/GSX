#! /bin/bash
#Primero se crean los directorios necesarios para tenerlos preparados

mkdir -p /empresa/usuaris /empresa/projectes /empresa/bin

#Modificaciones de permisos
chmod 1775 /empresa/bin
chmod 1770 /empresa/projectes
chown :users /empresa/bin
chown :users /empresa
chown :users /empresa/projectes
#Ahora se comprueba que se sea un usuario privilegiado para ejecutar el script


if [ "$EUID" -ne 0 ]; then
	echo "Este script requiere privilegios de superusuario para ejecutarse."
	exit 1
fi

#Se comprueba que se hayan pasado dos ficheros

if [ $# -eq 2 ]; then
	echo -e "Se han recibido los ficheros\n"

	#Se realiza lo sigueinte:
	#-Se recupera y crean los usuarios
	#-Se crean los grupos
	#-Se introducen los usuarios en los respectivos grupos

	echo -e "Recuperación de datos de usuarios del fichero [fitxer_prova_usuaris]"
	tail -n +2 "$1" | while IFS= read -r linea; do
    		dnis=$(echo "$linea" | awk -F ":" '{print $1}')
	        apellidos=$(echo "$linea" | awk -F ":" '{print $2}' | awk -F "," '{print $1}')
        	nombres=$(echo "$linea" | awk -F ":" '{print $2}' | awk -F "," '{sub(/^ */, "", $2); print $2}')
        	telefonos=$(echo "$linea" | awk -F ":" '{print $3}')
        	proyectos=$(echo "$linea" | awk -F ":" '{print $4}')

		#Se prepara el nombre del usuario como nombre + Iniciales del los apellidos

		iniciales=$(echo "$apellidos" | awk -F " " '{for (i=1; i<=NF; i++) printf substr($i,1,1)}' | tr '[:lower:]' '[:upper:]')
		nombre_aux=$(echo "$nombres" | tr -d ' ')
		usuario=$(echo "${nombre_aux}${iniciales}")

		#Primeros preparamos los grupos

		if  ! id "$usuario" &>/dev/null; then
			echo "El usuaio $usuario no existe"
			echo "[Creandolo]"
			useradd -m -d /empresa/usuaris/$usuario -s /bin/bash -N -p $dnis "$usuario" 2>/dev/null
			mkdir -p /empresa/usuaris/$usuario/bin
		fi
		passwd -d "$usuario" &>/dev/null
                chpasswd <<< "$usuario:$dnis" &>/dev/null

                for proyecto in $(echo "$proyectos" | tr ',' ' '); do
                        if ! grep -q "$proyecto" /etc/group 2>/dev/null; then
                                groupadd "$proyecto"
                        fi
                        usermod -aG $proyecto $usuario
                done


        	echo -e "\nDNIs: $dnis"
		id $usuario
	done

	echo -e "________________________________________________________________________________"

	#Recuperacion de proyectos
	echo -e "Recuperación de datos de proyectos del fichero [fitxer_prova_projectes]"
        tail -n +2 "$2" | while IFS= read -r linea; do
								proyecto=$(echo "$linea" | awk -F ":" '{print $1}' | awk -F "," '{sub(/^ */, "", $1); print $1}')
                DNIjefe=$(echo "$linea" | awk -F ":" '{print $2}' | awk -F "," '{sub(/^ */, "", $1); print $1}')
                descripcione=$(echo "$linea" | awk -F ":" '{print $3}' | awk -F "," '{sub(/^ */, "", $1); print $1}')
								#Crear direcotrios
								echo "Creando directorios para el proyecto: $proyecto"
								mkdir -p /empresa/projectes/$proyecto

								#Añado el propietario, el grupo, y los permisos
								apellidos=$(cat fitxer_prova_usuaris | grep "$DNIjefe" | awk -F ":" '{print $2}' | awk -F "," '{print $1}' | awk -F " " '{for (i=1; i<=NF; i++) printf substr($i,1,1)}' | tr '[:lower:]' '[:upper:]')
			        	nombres=$(cat fitxer_prova_usuaris | grep "$DNIjefe" | awk -F ":" '{print $2}' | awk -F "," '{sub(/^ */, "", $2); print $2}' | tr -d ' ')
								propietario=$(echo "${nombres}${apellidos}")
								chown $propietario:$proyecto /empresa/projectes/$proyecto
								chmod 1770 /empresa/projectes/$proyecto
								echo "jefe: $DNIjefe | Propietario: $propietario"
	done

	NUEVO_PATH1="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/empresa/bin"
	NUEVO_PATH2="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/empresa/bin"
	if [ -f /etc/profile.d/modifications.sh ]; then
		touch /etc/profile.d/modifications.sh
	fi
	#Modificar path de los usuarios
	cp /etc/profile /tmp
	echo '#!/bin/bash' > /etc/profile.d/modifications.sh
	echo 'if [ "$(id -u)" -eq 0 ]; then' >> /etc/profile.d/modifications.sh
	echo "PATH=\"$NUEVO_PATH1\"" >> /etc/profile.d/modifications.sh
	echo 'else' >> /etc/profile.d/modifications.sh
	echo "PATH=\"\$HOME/bin:$NUEVO_PATH2\"" >> /etc/profile.d/modifications.sh
	echo 'fi' >> /etc/profile.d/modifications.sh
	echo 'export PATH' >> /etc/profile.d/modifications.sh
	echo 'umask 1007' >> /etc/profile.d/modifications.sh #Cuando alguien se loggea se ignora el sticky bit
	#No se puede poner los permisos de ejecución, asi que estos los deberan poner los propios usuarios cuando esten dentro del sistema y permitir quienes pueden o no ejecutar sus scripts


else
	echo "No se ha recibido nada"
fi
