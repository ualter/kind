#!/bin/bash

clear
if [ -z "$1" ]; then
	echo "ERROR! Please inform Cluster Name"
	echo ""
	exit
fi

rm -f kind-config.yaml
echo ""
echo "*******************"
echo " Creating Cluster "
echo "*******************"
echo "kind: Cluster" >> kind-config.yaml
echo "apiVersion: kind.x-k8s.io/v1alpha4" >> kind-config.yaml
echo "nodes:" >> kind-config.yaml
echo "  - role: control-plane" >> kind-config.yaml
echo "    kubeadmConfigPatches:" >> kind-config.yaml
echo "    - |" >> kind-config.yaml
echo "      kind: InitConfiguration" >> kind-config.yaml
echo "      nodeRegistration:" >> kind-config.yaml
echo "        kubeletExtraArgs:" >> kind-config.yaml
echo "          node-labels: \"ingress-ready=true\"" >> kind-config.yaml
echo "    extraPortMappings:" >> kind-config.yaml
echo "    - containerPort: 80" >> kind-config.yaml
echo "      hostPort: 80" >> kind-config.yaml
echo "      protocol: TCP" >> kind-config.yaml
echo "    - containerPort: 443" >> kind-config.yaml
echo "      hostPort: 443" >> kind-config.yaml
echo "      protocol: TCP" >> kind-config.yaml

kind create cluster --name $1 --config ./kind-config.yaml

echo ""
echo " --> Now, operators/extensions... "
echo "     ./install-metallb.sh"
echo "     ./install-ingress-nginx.sh" 
echo "     ./install-jaeger-operator.sh" 
echo "     ./install-dashboard.sh" 
echo "     ./giveme-token-dashboard.sh"
echo ""

rm kind-config.yaml



