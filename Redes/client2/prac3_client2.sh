#! /bin/bash

# Ruta al archivo dhclient.conf
NAME=$HOSTNAME
ifdown eth0
# Agregar configuración al archivo dhclient.conf
sed -i "/send host-name/c\send host-name = $NAME;" /etc/dhcp/dhclient.conf
sed -i "s/\#send dhcp-lease-time 3600;/request dhcp-lease-time 86400;/" /etc/dhcp/dhclient.conf

#if ! grep -q 'request domain-name, domain-name-servers;' /etc/dhcp/dhclient.conf; then
#    echo 'request domain-name, domain-name-servers;' >> /etc/dhcp/dhclient.conf
#fi


cp actualitza_nom_local /etc/dhcp/dhclient-exit-hooks.d/ 
chmod a+r /etc/dhcp/dhclient-exit-hooks.d/actualitza_nom_local
chmod a+x /etc/dhcp/dhclient-exit-hooks.d/actualitza_nom_local

sed -i '/^send host-name = client1;/s/^/#/' /etc/dhcp/dhclient.conf

# Reiniciar el servicio dhclient
systemctl restart dhclient

# Levantar la interfaz eth0
ifup eth0
