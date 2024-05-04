#! /bin/bash
echo "-------------Prueba con gsxViewer-------------"
snmpget -v3 -u gsxViewer -l authNoPriv -a SHA -A aut84205317 localhost system.sysDescr.0
echo "-------------Prueba con gsxAdmin--------------"
snmpget -v3 -u gsxAdmin -l authPriv -a SHA -A aut84205317 -x DES -X sec84205317 localhost system.sysDescr.0
