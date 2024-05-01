#! /bin/bash

if [ $HOSTNAME=='server ];then
	sed -i 's/^#module(load="imudp")/module(load="imudp")/' /etc/rsyslog.conf
	sed -i 's/^#input(type="imudp" port="514")/input(type="imudp" port="514")/' /etc/rsyslog.conf
fi
