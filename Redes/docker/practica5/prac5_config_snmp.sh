#! /bin/bash
if [ "$HOSTNAME" == "server" ]; then
	sed -i 's/agentaddress  127.0.0.1,\[::1\]/agentAddress udp:161/g' /etc/snmp/snmpd.conf

	sed -i 's/sysLocation    Sitting on the Dock of the Bay/sysLocation    Casa/g' /etc/snmp/snmpd.conf 
	sed -i 's/sysContact     Me <me@example.org>/sysContact    Yo/g' /etc/snmp/snmpd.conf

	snmptranslate -IR -On IF-MIB::ifTable
	snmptranslate -IR -On IP-MIB::ipAddrTable
	snmptranslate -IR -On SNMPv2-MIB::snmp
	snmptranslate -IR -On SNMPv2-SMI::zeroDotZero
	snmptranslate -IR -On UCD-SNMP-MIB::extTable
	
	if ! grep -q "view vistagsx included .1.3.6.1.2.1.2.2" /etc/snmp/snmpd.conf; then
		echo "view vistagsx included .1.3.6.1.2.1.2.2" >> /etc/snmp/snmpd.conf
        	echo "view vistagsx included .1.3.6.1.2.1.4.20" >> /etc/snmp/snmpd.conf
        	echo "view vistagsx included .1.3.6.1.2.1.11" >> /etc/snmp/snmpd.conf
        	echo "view vistagsx included .0" >> /etc/snmp/snmpd.conf
        	echo "view vistagsx included .1.3.6.1.4.1.2021.2" >> /etc/snmp/snmpd.conf
		echo "rocommunity cilbup 127.0.0.1" >> /etc/snmp/snmpd.conf
		echo "proc mountd" >> /etc/snmp/snmpd.conf

	        echo "proc sshd" >> /etc/snmp/snmpd.conf
        	echo "proc named 10 1" >> /etc/snmp/snmpd.conf
        	echo "proc dhcpd" >> /etc/snmp/snmpd.conf
        	echo "proc rsyslog" >> /etc/snmp/snmpd.conf
		echo "proc mountd" >> /etc/snmp/snmpd.conf
        	echo "disk / 10000" >> /etc/snmp/snmpd.conf
        	echo "disk /var 5%" >> /etc/snmp/snmpd.conf
        	echo "includeAllDisks 10%" >> /etc/snmp/snmpd.conf

        	echo "load 12 10 5" >> /etc/snmp/snmpd.conf

	fi
	sed -i 's/mibs :/mibs +All/g' /etc/snmp/snmp.conf
	DNI="71350248"
	IND=$(echo $DNI | tr -cd [:digit:] | rev)

	if ! grep -q "createUser gsxViewer SHA aut$IND" /etc/snmp/snmpd.conf; then
		echo "createUser gsxViewer SHA aut$IND" >> /etc/snmp/snmpd.conf
                echo "createUser gsxAdmin SHA SHA sec$IND" >> /etc/snmp/snmpd.conf
                echo "rouser gsxViewer auth" >> /etc/snmp/snmpd.conf
                echo "rwuser gsxAdmin priv" >> /etc/snmp/snmpd.conf
	fi
	service snmpd restart

fi
