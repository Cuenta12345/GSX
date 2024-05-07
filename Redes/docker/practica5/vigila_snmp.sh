#!/bin/bash

# Constante para el umbral de incremento
LLINDAR=10

# Consulta SNMP para obtener el numero de solicitudes de tipo Set
snmpset=$(snmpget -v2c -c cilbup localhost SNMPv2-MIB::snmpInSetRequests.0 | awk '{print $4}')

# Consulta SNMP para obtener el numero de solicitudes de tipo Get
snmpget=$(snmpget -v2c -c cilbup localhost SNMPv2-MIB::snmpInGetRequests.0 | awk '{print $4}')

echo "Cantidad de set $snmpset"
echo "Cantidad de get $snmpget"

# Verificar si el numero de solicitudes de tipo Set ha aumentado
if [ $snmpset -gt 0 ]; then
    logger -p user.warning -t GSX "AVIS: el valor de SNMPv2-MIB::snmpInSetRequests al router ha aumentado demasiado: $snmpset"
fi

# Verificar si el numero de solicitudes de tipo Get ha aumentado por encima del umbral
if [ $snmpget -gt $LLINDAR ]; then
    logger -p user.warning -t GSX "AVIS: el valor de SNMPv2-MIB::snmpInGetRequests al router ha aumentado demasiado: $snmpget"
fi
