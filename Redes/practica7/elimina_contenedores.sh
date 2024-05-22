#! /bin/bash

node=1

while [ $node -le 4 ]; do
	docker stop R$node
	((node++))
done
