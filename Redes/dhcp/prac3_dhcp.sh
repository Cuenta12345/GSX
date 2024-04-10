#! /bin/bash

if ! grep -q "iface eth0 inet static" /etc/network/interfaces; then
	cp /etc/network/interfaces /etc/network/interfaces.backup
	sed -i '/auto eth0/d' /etc/network/interfaces
	sed -i '/iface eth0 inet dhcp/d' /etc/network/interfaces
	echo -e "auto eth0\niface eth0 inet static\n    address 172.24.248.94\n    netmask 255.255.255.240\n    gateway 172.24.248.81" >> /etc/network/interfaces
        systemctl restart networking
fi

sed -i '/^nameserver/d' /etc/resolv.conf

echo "nameserver 198.18.249.254" > /etc/resolv.conf
echo "search intranet.gsx dmz.gsx" >> /etc/resolv.conf
echo "nameserver 172.24.248.81" >> /etc/resolv.conf

if ! dpkg -s isc-dhcp-server &> /dev/null; then
   	echo "El paquete isc-dhcp-server no está instalado. Instalándolo..."
   	apt-get update
	apt-get install -y isc-dhcp-server
fi
if ! grep -q 'INTERFACESv4="eth0"' /etc/default/isc-dhcp-server; then
	cp /etc/default/isc-dhcp-server /etc/default/isc-dhcp-server.backup
	sed -i 's/INTERFACESv4=""/INTERFACESv4="eth0"/g' /etc/default/isc-dhcp-server
fi

if ! grep -q 'subnet 172.24.248.80 netmask 255.255.255.240' /etc/dhcp/dhcpd.conf; then
    cat <<EOF >> /etc/dhcp/dhcpd.conf
ddns-hostname= pick(option fqdn.hostname, option host-name,
		concat ("client-",binary-to-ascii(10,8,"-",
		substring(leased-address,3,1))));
option host-name = config-option server.ddns-hostname;
ddns-update-style interim;
ddns-updates on;
deny client-updates;

key "CLAU_DHCPDNS" {
        algorithm hmac-md5;
        secret "i3RmSIWU3VqB+4DVwIxZYg==";
};

subnet 172.24.248.80 netmask 255.255.255.240 {
  range 172.24.248.82 172.24.248.93;
  default-lease-time 7200;
  max-lease-time 28800;
  option routers 172.24.248.81;
  option domain-name-servers 198.18.249.254;
  option domain-name "intranet.gsx";
  option domain-search "intranet.gsx", "dmz.gsx";
}
zone intranet.gsx {
	primary 198.18.249.254;
	key CLAU_DHCPDNS;
}
zone 24.172.in-addr.arpa {
	primary 198.18.249.254;
	key CLAU_DHCPDNS;
}
EOF
fi

#sed -i '/option domain-name "example.org";/c\option domain-name "intrante.gsx";' /etc/dhcp/dhcpd.conf
sed -i '/#PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config
systemctl restart ssh
#option domain-name "example.org";
#option domain-name-servers ns1.example.org, ns2.example.org;

service isc-dhcp-server restart
