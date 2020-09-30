#!/bin/bash

clear
#if [ -z "$1" ]; then
#	echo "ERROR! Please inform Cluster Name"
#	echo ""
#	exit
#fi

echo ""
echo "***************************"
echo " Installing Ingress NGINX  "
echo "***************************"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
echo ""
echo "--> Waiting to start its Pods..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s


kubectl get all --namespace ingress-nginx
echo ""
echo "--> Ready!"
echo ""