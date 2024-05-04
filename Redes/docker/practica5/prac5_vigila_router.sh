#! /bin/bash

(crontab -l ; echo "*/5 * * * * /root/vigila_snmp.sh") | crontab -

# Mensaje de confirmación
echo "Cron configurado para ejecutar /root/vigila_snmp.sh cada 5 minutos."
