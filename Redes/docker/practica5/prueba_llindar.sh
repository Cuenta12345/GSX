#!/bin/bash

snmpset -v3 -u gsxAdmin -l authPriv -a SHA -A aut84205317 -x DES -X sec84205317 198.18.248.1 ip.ipForwarding.0 = 1
snmpset -v3 -u gsxAdmin -l authPriv -a SHA -A aut84205317 -x DES -X sec84205317 198.18.248.1 sysName.0 = 'Router'

contador=0
while [ $contador -lt 10 ]; do
	snmpset -v3 -u gsxAdmin -l authPriv -a SHA -A aut84205317 -x DES -X sec84205317 198.18.248.1 sysName.0 = 'Router'
	snmpget -v3 -u gsxAdmin -l authPriv -a SHA -A aut84205317 -x DES -X sec84205317 198.18.248.1 sysName.0
	((contador++))
done
