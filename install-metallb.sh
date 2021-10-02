#!/bin/bash

clear
echo ""
echo "********************"
echo " Installing Metallb "
echo "********************"
echo ""
echo "Creating the metallb namespace..."
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/namespace.yaml
echo "Creating the memberlist secrets..."
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
echo "Applying metallb manifest..."
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/metallb.yaml
echo "Waiting to start its Pods..."
kubectl get pods -n metallb-system --watch
echo "Creating configmap..."
wget -q -N https://kind.sigs.k8s.io/examples/loadbalancer/metallb-configmap.yaml -O metallb-configmap.yaml
head -n -1 metallb-configmap.yaml > metallb-configmap2.yaml
mv metallb-configmap2.yaml metallb-configmap.yaml
CIDR=$(docker network inspect -f '{{.IPAM.Config}}' kind | cut -d ' ' -f 1 | cut -d '{' -f 2)
BITMASK=$(echo $CIDR | cut -f 2 -d '/')
IP=$(echo $CIDR | cut -f 1 -d '/')
BYTES=$(( $BITMASK / 8 ))
BASEADDRESS=$(echo $IP | cut -f 1-$BYTES -d '.')
echo "      - ${BASEADDRESS}.255.200-${BASEADDRESS}.255.250" >> metallb-configmap.yaml
kubectl apply -f metallb-configmap.yaml
rm metallb-configmap.yaml
echo "--> Ready!"
echo ""