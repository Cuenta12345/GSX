#! /bin/bash
echo -e "\n-------------Primeras pruebas-------------" > sortida_snmp_remota_prac5.txt
snmptranslate -Td -OS UCD-SNMP-MIB::ucdavis.dskTable >> sortida_snmp_remota_prac5.txt

echo -e "\n-------------Primeras pruebas en Remoto-------------" >> sortida_snmp_remota_prac5.txt
echo -e "\n-------------Prueba de system-------------" >> sortida_snmp_remota_prac5.txt
snmpwalk -v 2c -c public 198.18.248.1 system >> sortida_snmp_remota_prac5.txt

echo -e "\n-------------Prueba de system V3 gsxViewer-------------" >> sortida_snmp_remota_prac5.txt 
snmpwalk -v3 -u gsxViewer -l authNoPriv -a SHA -A aut84205317 198.18.248.1 system >> sortida_snmp_remota_prac5.txt

echo -e "\n-------------Prueba de system V3 gsxAdmin-------------" >> sortida_snmp_remota_prac5.txt 
snmpwalk -v3 -u gsxAdmin -l authPriv -a SHA -A aut84205317 -x DES -X sec84205317 198.18.248.1 system >> sortida_snmp_remota_prac5.txt

echo -e "\n-------------Prueba de hrSystem-------------" >> sortida_snmp_remota_prac5.txt
snmpwalk -v 2c -c public 198.18.248.1 hrSystem >> sortida_snmp_remota_prac5.txt

echo -e "\n-------------Prueba de hrSystem V3 gsxViewer-------------" >> sortida_snmp_remota_prac5.txt 
snmpwalk -v3 -u gsxViewer -l authNoPriv -a SHA -A aut84205317 198.18.248.1 hrSystem >> sortida_snmp_remota_prac5.txt

echo -e "\n-------------Prueba de hrSystem V3 gsxAdmin-------------" >> sortida_snmp_remota_prac5.txt 
snmpwalk -v3 -u gsxAdmin -l authPriv -a SHA -A aut84205317 -x DES -X sec84205317 198.18.248.1 hrSystem >> sortida_snmp_remota_prac5.txt

echo -e "\n-------------Pruebas acceso mibs de la Univ Remotas con gsxViewer-------------" >> sortida_snmp_remota_prac5.txt
snmptable -v3 -u gsxViewer -l authNoPriv -a SHA -A aut84205317 198.18.248.1 UCD-SNMP-MIB::prTable >> sortida_snmp_remota_prac5.txt
snmptable -v3 -u gsxViewer -l authNoPriv -a SHA -A aut84205317 198.18.248.1 ucdavis.dskTable >> sortida_snmp_remota_prac5.txt
snmptable -v3 -u gsxViewer -l authNoPriv -a SHA -A aut84205317 198.18.248.1 ucdavis.laTable >> sortida_snmp_remota_prac5.txt

echo -e "\n-------------Pruebas acceso mibs de la Univ Remotas con gsxAdmin-------------" >> sortida_snmp_remota_prac5.txt
snmptable -v3 -u gsxAdmin -l authPriv -a SHA -A aut84205317 -x DES -X sec84205317 198.18.248.1 UCD-SNMP-MIB::prTable >> sortida_snmp_remota_prac5.txt
snmptable -v3 -u gsxAdmin -l authPriv -a SHA -A aut84205317 -x DES -X sec84205317 198.18.248.1 ucdavis.dskTable >> sortida_snmp_remota_prac5.txt
snmptable -v3 -u gsxAdmin -l authPriv -a SHA -A aut84205317 -x DES -X sec84205317 198.18.248.1 ucdavis.laTable >> sortida_snmp_remota_prac5.txt

echo -e "\n-------------Prueba Remota con gsxViewer-------------" >> sortida_snmp_remota_prac5.txt
snmpget -v3 -u gsxViewer -l authNoPriv -a SHA -A aut84205317 198.18.248.1 system.sysDescr.0 >> sortida_snmp_remota_prac5.txt
echo -e "\n-------------Prueba Remota con gsxAdmin--------------" >> sortida_snmp_remota_prac5.txt
snmpget -v3 -u gsxAdmin -l authPriv -a SHA -A aut84205317 -x DES -X sec84205317 198.18.248.1 system.sysDescr.0 >> sortida_snmp_remota_prac5.txt
