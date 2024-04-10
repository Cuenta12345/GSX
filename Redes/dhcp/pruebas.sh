#! /bin/bash

echo -e "\nPruebas de consultas directas a todas las zonas\n"
dig +search ns
dig +search server
dig +search www
dig +search router
dig +search dhcp
dig +recurse tinet.cat

echo -e "\nPruebas de consultas inversas a todas las zonas\n"
dig +search -x 198.18.249.254
dig +search -x 198.18.248.1
dig +search -x 172.24.248.81 
dig +search -x 172.24.248.94

echo -e "\nPruebas de ping de extremo a extremo\n"
ping -c 1 ns
ping -c 1 server
ping -c 1 www
ping -c 1 router
ping -c 1 dhcp
ping -c 1 google.com
