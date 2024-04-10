#! /bin/bash

sed -i '/^nameserver/{N;N;d}' /etc/resolv.conf

if ! grep -q "nameserver 8.8.8.8" /etc/resolv.conf; then 
        echo "nameserver 8.8.8.8" >> /etc/resolv.conf 
fi

echo "Añadimos dns de google para instalar"

#A)
if ! grep -q "iface eth0 inet static" /etc/network/interfaces; then
	echo -e "auto eth0\niface eth0 inet static\n    address 198.18.249.254\n    netmask 255.255.254.0\n    gateway 198.18.248.1" >> /etc/network/interfaces
	systemctl restart networking
fi

echo "Ip asiganda"

#B)

#C)
#if ! grep -q "198.18.248.1\s\+router" /etc/hosts; then
   	#echo -e "198.18.248.1\trouter" >> /etc/hosts
#fi

#E)
dpkg -s openssh-server > /dev/null 2>&1
if [ $? -eq 0 ]; then
    	echo "openssh-server ya está instalado."
else
    	apt install -y openssh-server
    	systemctl status ssh
    	ss -4lnt | grep ":22 "
fi
sed -i '/#PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config
sed -i '/PermitRootLogin no/c\PermitRootLogin yes' /etc/ssh/sshd_config
systemctl restart ssh

echo "ssh instalado y preparado"


#)SEGUNDA PARTE (LAB6)
#if ! grep -q "nameserver 198.18.248.1" /etc/resolv.conf; then 
#	echo "nameserver 198.18.248.1" >> /etc/resolv.conf 
#fi

#)TERCERA PARTE (LAB7)

required_packages=("bind9" "bind9-doc" "dnsutils")
for package in "${required_packages[@]}"; do
    apt-get install -y "$package"
done

echo "Paquetes para DNS instalados y preparados"

#NUEVOS_FORWARDES=$(ssh router "grep \"^nameserver\" /etc/resolv.conf" | awk '{print $2}')

#sed -i "/^options {/a\    forwarders { $NUEVOS_FORWARDES; };" named.conf.options
sed -i 's/OPTIONS=.*/OPTIONS="-u bind -4"/' /etc/default/named

chmod --reference=/etc/bind/named.conf named.conf
chmod --reference=/etc/bind/named.conf.default-zones named.conf.default-zones
chmod --reference=/etc/bind/named.conf.local named.conf.local
chmod --reference=/etc/bind/named.conf.options named.conf.options

cp named* /etc/bind/
cp db.* /var/cache/bind/

chmod a+r /var/cache/bind/db.*
chown :bind /var/cache/bind/db.*

/sbin/named-checkzone 'intranet.gsx' /var/cache/bind/db.intranet.gsx 
/sbin/named-checkzone 'dmz.gsx' /var/cache/bind/db.dmz.gsx 
/sbin/named-checkzone '18.198.in-addr.arpa' /var/cache/bind/db.198.18 
/sbin/named-checkzone '24.172.in-addr.arpa' /var/cache/bind/db.172.24.248

if [ ! -d /var/log/bind/ ]; then
	mkdir /var/log/bind/
fi
touch /var/log/bind/update_debug.log
chown -R bind:bind /var/log/bind
chmod -R 755 /var/log/bind/update_debug.log  

if [ -f /var/cache/bind/db.intranet.gsx.jnl ]; then
	rm /var/cache/bind/db.intranet.gsx.jnl
fi

if [ -f /var/cache/bind/db.172.24.248.jnl ]; then
        rm /var/cache/bind/db.172.24.248.jnl
fi


systemctl restart named

echo "Servicio preparado"

sed -i '/^nameserver/{N;N;d}' /etc/resolv.conf

# Agregar los nuevos nameservers
echo "nameserver 127.0.0.1" >> /etc/resolv.conf

# Agregar la configuración de búsqueda
echo "search dmz.gsx intranet.gsx" >> /etc/resolv.conf

if grep -q "nameserver 8.8.8.8" /etc/resolv.conf; then
    # Si la línea está presente, la eliminamos
    sed -i '/nameserver 8.8.8.8/d' /etc/resolv.conf
fi

echo "/etc/resolv.conf preparado"
