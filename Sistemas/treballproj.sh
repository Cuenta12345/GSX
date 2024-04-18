#!/bin/bash

# Comprobar si se proporciona un argumento
if [ $# -ne 1 ]; then
    echo "Usage: $0 <nom_del_projecte>"
    exit 1
fi

# Nombre del proyecto
actual_dir=$(pwd)
new_directorio="/empresa/projectes/$1"
old_umask=$(umask)
id
newgrp - $1
id
