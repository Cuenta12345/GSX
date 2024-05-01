#! /bin/bash

# Ruta del archivo de configuracion logrotate
LOGROTATE_CONF="/etc/logrotate.d/remots"

# Contenido del archivo de configuracion logrotate
CONFIG_CONTENT="/var/log/remots/*/*.log {
    daily
    compress
    rotate 180
    missingok
    notifempty
    delaycompress
    create 0644 root root
}"

# Verificar si el host es 'server'
if [ "$HOSTNAME" == 'server' ]; then
	# Configurar rsyslog
	sed -i '/imudp/s/^#//g' /etc/rsyslog.conf
	cp ./10-remot.conf /etc/rsyslog.d/

	# Crear archivo de configuracion logrotate si no existe
	if [ ! -e "$LOGROTATE_CONF" ]; then
        	echo "$CONFIG_CONTENT" | tee "$LOGROTATE_CONF" > /dev/null
        	if [ $? -eq 0 ]; then
            		echo "Archivo de configuracion logrotate creado correctamente en: $LOGROTATE_CONF"
        	else
            		echo "Error al crear el archivo de configuracion logrotate"
            		exit 1
        	fi
	else
        	echo "El archivo de configuracion logrotate ya existe: $LOGROTATE_CONF"
    	fi
	service rsyslog restart
	ss -tuln | grep 514
else
	cp ./90-remot.conf /etc/rsyslog.d/
	service rsyslog restart
fi
