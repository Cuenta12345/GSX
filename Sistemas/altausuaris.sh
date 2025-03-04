#! /bin/bash
#Primero se crean los directorios necesarios para tenerlos preparados

#Ahora se comprueba que se sea un usuario privilegiado para ejecutar el script
if [ "$EUID" -ne 0 ]; then
	echo "Este script requiere privilegios de superusuario para ejecutarse."
	exit 1
fi

#Se comprueba que se hayan pasado dos ficheros

if [ $# -eq 2 ]; then
	echo -e "Se han recibido los ficheros\n"

	#Primero se crean los directorios necesarios para tenerlos preparados
	mkdir -p /empresa/usuaris /empresa/projectes /empresa/bin

	#Modificaciones de permisos
	chmod 1777 /empresa/bin
	chmod 1770 /empresa/projectes

	#Modifcamos porpietarios
	chown :users /empresa
	chown :users /empresa/bin
	chown :users /empresa/projectes

	#Se realiza lo sigueinte:
	#-Se recupera y crean los usuarios
	#-Se crean los grupos
	#-Se introducen los usuarios en los respectivos grupos

	echo -e "Recuperación de datos de usuarios del fichero [fitxer_prova_usuaris]"
	tail -n +2 "$1" | while IFS= read -r linea; do
		#Se recogen datos
    		dnis=$(echo "$linea" | awk -F ":" '{print $1}')
	        apellidos=$(echo "$linea" | awk -F ":" '{print $2}' | awk -F "," '{print $1}')
        	nombres=$(echo "$linea" | awk -F ":" '{print $2}' | awk -F "," '{sub(/^ */, "", $2); print $2}')
        	telefonos=$(echo "$linea" | awk -F ":" '{print $3}')
        	proyectos=$(echo "$linea" | awk -F ":" '{print $4}')

		#Se prepara el nombre del usuario como nombre + Iniciales del los apellidos
			iniciales=$(echo "$apellidos" | awk -F " " '{for (i=1; i<=NF; i++) printf substr($i,1,1)}' | tr '[:lower:]' '[:upper:]')
			nombre_aux=$(echo "$nombres" | tr -d ' ')
			usuario=$(echo "${nombre_aux}${iniciales}")

		#Primeros preparamos los usuarios y sus directorios
		usuario_base="$usuario"
		numero=1
		while id "$usuario" &>/dev/null; do
			usuario="${usuario_base}${numero}"
			((numero++))
		done

		echo "El usuario $usuario no existe"
		echo "[Creándolo]"
		useradd -m -d "/empresa/usuaris/$usuario" -s /bin/bash -N -p "$dnis" "$usuario" -c "$dnis, $tel" 2>/dev/null
		chmod 1700 "/empresa/usuaris/$usuario"

		mkdir -p "/empresa/usuaris/$usuario/bin"
		chown "$usuario:users" "/empresa/usuaris/$usuario/bin"
		chmod 1700 "/empresa/usuaris/$usuario/bin"
		#Se cambian contraseñas
		passwd -d "$usuario" &>/dev/null
    	chpasswd <<< "$usuario:$dnis" &>/dev/null

		#Se crean grupos y se añaden los usuarios a los grupos
    for proyecto in $(echo "$proyectos" | tr ',' ' '); do
    	if ! grep -q "$proyecto" /etc/group 2>/dev/null; then
          groupadd "$proyecto"
					gpasswd -r "$proyecto"
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

	#Se crean los nuevos PATH
	NUEVO_PATH1="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/empresa/bin"
	NUEVO_PATH2="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/empresa/bin"

	#Se crea un nuevo fichero para que se ejecute al inciar sesión
	if [ -f /etc/profile.d/modifications.sh ]; then
		touch /etc/profile.d/modifications.sh
	fi

	#Modificar path de los usuarios en el nuevo script
	cp /etc/profile /tmp
	echo '#!/bin/bash' > /etc/profile.d/modifications.sh
	echo 'if [ "$(id -u)" -eq 0 ]; then' >> /etc/profile.d/modifications.sh
	echo "PATH=\"$NUEVO_PATH1\"" >> /etc/profile.d/modifications.sh
	echo 'else' >> /etc/profile.d/modifications.sh
	echo "PATH=\"\$HOME/bin:$NUEVO_PATH2\"" >> /etc/profile.d/modifications.sh
	echo 'fi' >> /etc/profile.d/modifications.sh
	echo 'export PATH' >> /etc/profile.d/modifications.sh
	echo 'umask 027' >> /etc/profile.d/modifications.sh #Cuando alguien se loggea se ignora el sticky bit
	echo 'mkdir $HOME/tmp' >> /etc/profile.d/modifications.sh

	#echo 'if [ ! -d "$HOME/tmp" ]; then' >> /etc/profile.d/modifications.sh
	#echo 'mkdir -p "$HOME/tmp"' >> /etc/profile.d/modifications.sh
	echo 'mount -t tmpfs -o size=100M,mode=0700,uid=$USER,gid=users tmpfs "$HOME/tmp"' >> /etc/profile.d/modifications.sh
	#echo 'fi' >> /etc/profile.d/modifications.sh


	#No se puede poner los permisos de ejecución, asi que estos los deberan poner los propios usuarios cuando esten dentro del sistema y permitir quienes pueden o no ejecutar sus scripts

	#Copiamos el archivo de treballproj.sh a su sitio en /empresa/bin
	chmod 755 treballproj.sh
	cp ./treballproj.sh /empresa/bin

else
	echo "No se ha recibido nada"
fi
