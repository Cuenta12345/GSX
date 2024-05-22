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
echo -e "Añadiendo IPs\n"
node=1
while [ $node -le 4 ]; do
	pid=$(docker inspect --format '{{.State.Pid}}' R$node)
	if [ $node -eq 1 ]; then
		nsenter -t $pid -n ip addr add 10.248.$node.1/30 dev link${node}_veth1
		nsenter -t $pid -n ip link set dev link${node}_veth1 up

		nsenter -t $pid -n ip addr add 10.248.4.2/30 dev link4_veth2
		nsenter -t $pid -n ip link set dev link4_veth2 up
	else
                preNode=$((node - 1))
		nsenter -t $pid -n ip addr add 10.248.$node.1/30 dev link${node}_veth1
    		nsenter -t $pid -n ip link set dev link${node}_veth1 up

		nsenter -t $pid -n ip addr add 10.248.$preNode.2/30 dev link${preNode}_veth2
		nsenter -t $pid -n ip link set dev link${preNode}_veth2 up
        fi
        ((node++))

done
