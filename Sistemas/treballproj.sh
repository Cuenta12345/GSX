#!/bin/bash

# Comprobar si se proporciona un argumento
if [ $# -ne 1 ]; then
    echo "Usage: $0 <nom_del_projecte>"
    exit 1
fi

cd /empresa/projectes/$1
umask 007
newgrp $1
exit 0
