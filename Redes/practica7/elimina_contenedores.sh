#! /bin/bash

node=1

while [ $node -le 4 ]; do
	docker stop R$node
	((node++))
done
docker rmi gsx:prac7
docker rmi debian:buster-slim
