#! /bin/bash

echo "*/5 * * * * /ruta/al/script.sh" >> mycron

crontab mycron

rm mycron
echo "Cron configurado para ejecutar /root/vigila_snmp.sh cada 5 minutos."
