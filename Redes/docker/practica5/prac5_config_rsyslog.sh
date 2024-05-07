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

	service rsyslog restart
	ss -tuln | grep 514
else
	cp ./90-remot.conf /etc/rsyslog.d/
	service rsyslog restart
fi
