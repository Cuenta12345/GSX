#! /bin/bash

#Borramos los usuarios
sudo userdel "JoanJosepLDA"
sudo userdel "AnnaGS"
sudo userdel "DanielSR"
sudo userdel "MariaPG"

#Eliminamos los grupos
sudo groupdel "Administracio"
sudo groupdel "Raspberry"
sudo groupdel "Disseny"
sudo groupdel "Marqueting"

#Eliminamos todo el sistema de directorios
sudo rm -r /empresa
