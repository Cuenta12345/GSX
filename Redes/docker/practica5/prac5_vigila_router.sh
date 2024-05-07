#! /bin/bash

(crontab -l ; echo "*/5 * * * * ./root/prac5/vigila_snmp.sh") | crontab -
echo "Cron configurado para ejecutar /root/vigila_snmp.sh cada 5 minutos."
service cron start
