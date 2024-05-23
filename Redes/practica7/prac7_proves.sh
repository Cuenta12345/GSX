#! /bin/bash

echo -e "Comprobación de tabla de encadenamiento de cada router"
node=1
while [ $node -le 4 ]; do
	echo "Router R$node:"
	docker exec R$node ip -c route | tee -a sortida_prac7.txt
	((node++))
	echo -e "\n"
done

echo -e "\nPruebas de ping entre routers\n"
echo -e "De R1 a todos\n"
docker exec R1 ping -c1 10.248.1.2
docker exec R1 ping -c1 10.248.2.1
docker exec R1 ping -c1 10.248.2.2
docker exec R1 ping -c1 10.248.3.1
docker exec R1 ping -c1 10.248.3.2
docker exec R1 ping -c1 10.248.4.1
docker exec R1 ping -c1 10.248.4.2

echo -e "\nPrueba de traceroute de R1 a todos\n"
docker exec R1 traceroute -n 10.248.1.2 | tee -a sortida_prac7.txt
docker exec R1 traceroute -n 10.248.2.1 | tee -a sortida_prac7.txt
docker exec R1 traceroute -n 10.248.2.2 | tee -a sortida_prac7.txt
docker exec R1 traceroute -n 10.248.3.1 | tee -a sortida_prac7.txt
docker exec R1 traceroute -n 10.248.3.2 | tee -a sortida_prac7.txt
docker exec R1 traceroute -n 10.248.4.1 | tee -a sortida_prac7.txt
docker exec R1 traceroute -n 10.248.4.2 | tee -a sortida_prac7.txt

echo -e "\nPruebas de los otros routers a los demas\n"
echo -e "Desde R2\n"
docker exec R2 traceroute -n -T 10.248.4.1 | tee -a sortida_prac7.txt
docker exec R2 traceroute -n -T 10.248.4.2 | tee -a sortida_prac7.txt
docker exec R2 traceroute -n -T 10.248.3.1 | tee -a sortida_prac7.txt
docker exec R2 traceroute -n -T 10.248.3.2 | tee -a sortida_prac7.txt
docker exec R2 traceroute -n -T 10.248.1.1 | tee -a sortida_prac7.txt
echo -e "\nDesde R3\n"
docker exec R3 traceroute -n -T 10.248.4.1 | tee -a sortida_prac7.txt
docker exec R3 traceroute -n -T 10.248.4.2 | tee -a sortida_prac7.txt
docker exec R3 traceroute -n -T 10.248.2.1 | tee -a sortida_prac7.txt
docker exec R3 traceroute -n -T 10.248.2.2 | tee -a sortida_prac7.txt
docker exec R3 traceroute -n -T 10.248.1.1 | tee -a sortida_prac7.txt
echo -e "\nDesde R4\n"
docker exec R4 traceroute -n -T 10.248.3.1 | tee -a sortida_prac7.txt
docker exec R4 traceroute -n -T 10.248.3.2 | tee -a sortida_prac7.txt
docker exec R4 traceroute -n -T 10.248.2.1 | tee -a sortida_prac7.txt
docker exec R4 traceroute -n -T 10.248.2.2 | tee -a sortida_prac7.txt
docker exec R4 traceroute -n -T 10.248.1.1 | tee -a sortida_prac7.txt

echo -e "\nPara la prueba de caida de red se usaran los routers R2 y R4 que estan cada uno es una esquina\n"
echo -e "Comprobamos la ruta desde R1 a las dos IPs de r3\n"
docker exec R1 traceroute -n -T 10.248.4.1 | tee -a sortida_prac7.txt
docker exec R1 traceroute -n -T 10.248.4.2 | tee -a sortida_prac7.txt
echo -e "\n Bajamos la interfaz de R4 que se conecta con R1"
docker exec R3 ip link set dev link4_veth1 down | tee -a sortida_prac7.txt
echo -e "\n Comprobamos como llega ahora\n"
docker exec R1 traceroute -n -T 10.248.4.1 | tee -a sortida_prac7.txt
docker exec R1 traceroute -n -T 10.248.4.2 | tee -a sortida_prac7.txt

