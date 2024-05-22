#! /bin/bash

echo -e "Creando ficheros:\n"
touch /etc/quagga/zebra.conf
touch /etc/quagga/ripd.conf

if [ $HOSTNAME -eq 1 ]; then
cat <<EOT >> /etc/quagga/ripd.conf
	router rip
	version 2
	default-information originate
	passive-interface eth0
	network 10.248.1.0/30
	network 10.248.4.0/30
EOT
	echo 1 > /proc/sys/net/ipv4/ip_forward
	iptables -t nat -A POSTROUTING -s 10.248.1.0/30 -o 172.17.0.2 -j MASQUERADE
	iptables -t nat -A POSTROUTING -s 10.248.4.0/30 -o 172.17.0.2 -j MASQUERADE

else
	preNode=$($HOSTANAME-1)
cat <<EOT >> /etc/quagga/ripd.conf
	router rip
	version 2
	network 10.248.$HOSTNAME.0/30
	network 10.248.$preNode.0/30
EOT
fi
