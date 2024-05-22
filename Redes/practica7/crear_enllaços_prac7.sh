#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como superusuario (sudo)" 
  exit 1
fi

echo -e "Creando redes\n"
node=1
while [ $node -le 4 ]; do
    ip link add link${node}_veth1 type veth peer name link${node}_veth2
    ((node++))
done

echo -e "uniendo contenedores a redes\n"
node=1
while [ $node -le 4 ]; do
	pid=$(docker inspect --format '{{.State.Pid}}' R$node)
	if [ $node -eq 1 ]; then
		ip link set netns $pid dev link${node}_veth1
		ip link set netns $pid dev link4_veth2
	else
		preNode=$((node - 1))
		ip link set netns $pid dev link${node}_veth1
		ip link set netns $pid dev link${preNode}_veth2
	fi
	((node++))
done
