#! /bin/bash

echo -e "Comprobación de tabla de encadenamiento de cada router"
node=1
while [ $node -le 4 ]; do
	echo "Router R$node:"
	docker exec R$node ip -c route | tee -a sortida_prac7.txt
	((node++))
	echo -e "\n"
done
