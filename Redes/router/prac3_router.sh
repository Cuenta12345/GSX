#! /bin/bash

#A)
if ! ip addr show eth1 | grep -q "198.18.248.1/23"; then
    ip address add 198.18.248.1/23 dev eth1
fi

#B)
if [ "$(cat /proc/sys/net/ipv4/ip_forward)" -ne 1 ]; then
    echo 1 > /proc/sys/net/ipv4/ip_forward
fi

#C)
#if ! grep -q "198.18.249.254\s\+server" /etc/hosts; then
#     echo -e "198.18.249.254\tserver" >> /etc/hosts
#fi

#D)
if ! iptables -t nat -C POSTROUTING -s 198.18.248.0/23 -o eth0 -j MASQUERADE &>/dev/null; then
    iptables -t nat -A POSTROUTING -s 198.18.248.0/23 -o eth0 -j MASQUERADE
fi

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


#) SEGUNDA PARTE (LAB6)
if ! ip addr show eth2 | grep -q "172.24.248.81/28"; then
    ip address add 172.24.248.81/28 dev eth2
fi

if ! iptables -t nat -C POSTROUTING -s 172.24.248.80/28 -o eth0 -j MASQUERADE &>/dev/null; then
    iptables -t nat -A POSTROUTING -s 172.24.248.80/28 -o eth0 -j MASQUERADE
fi

#if ! iptables -t nat -A PREROUTING -i eth2 -d 172.24.248.81 -p udp --dport 53 -j DNAT --to-destination 8.8.8.8:53 &>/dev/null; then
#    iptables -t nat -A PREROUTING -i eth2 -d 172.24.248.81 -p udp --dport 53 -j DNAT --to-destination 8.8.8.8:53
#fi

#if ! iptables -t nat -A PREROUTING -i eth1 -s 198.18.248.0/23 -p udp --dport 53 -j DNAT --to-destination 8.8.8.8:53 &>/dev/null; then
#    iptables -t nat -A PREROUTING -i eth1 -s 198.18.248.0/23 -p udp --dport 53 -j DNAT --to-destination 8.8.8.8:53
#fi

#) TERCERA PARTE

sed -i '/#prepend domain-name-servers 127.0.0.1;/c\prepend domain-name-servers 198.18.249.254;' /etc/dhcp/dhclient.conf
sed -i '/#supersede domain-name .*/c\supersede domain-name "dmz.gsx intranet.gsx";' /etc/dhcp/dhclient.conf
systemctl restart dhclient

if ! iptables -A FORWARD -o eth0 -p udp --dport 53 ! -s 198.18.249.254 -j DROP &>/dev/null; then
    iptables -A FORWARD -o eth0 -p udp --dport 53 ! -s 198.18.249.254 -j DROP
    echo "Primera iptables echa"
fi

if ! iptables -A FORWARD -o eth0 -p tcp --dport 53 ! -s 198.18.249.254 -j DROP &>/dev/null; then
    iptables -A FORWARD -o eth0 -p tcp --dport 53 ! -s 198.18.249.254 -j DROP
    echo "Primera iptables echa"
fi


if ! iptables-save | grep -q -- " -A PREROUTING -i eth0 -p udp --dport 53 -j DNAT --to-destination 198.18.249.254:53"; then
    iptables -t nat -A PREROUTING -i eth0 -p udp --dport 53 -j DNAT --to-destination 198.18.249.254:53
    echo "Segunda iptables echa"
fi

if ! iptables-save | grep -q -- " -A PREROUTING -i eth0 -p tcp --dport 53 -j DNAT --to-destination 198.18.249.254:53"; then
    iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 53 -j DNAT --to-destination 198.18.249.254:53
    echo "Segunda iptables echa"
fi


ifdown eth0
ifup eth0
