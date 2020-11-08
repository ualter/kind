#!/bin/bash

clear
if [ -z "$1" ]; then
	echo "ERROR! Please inform Cluster Name"
	echo ""
	exit
fi

rm -f kind-3nodes.yaml
echo ""
echo "*******************"
echo " Creating Cluster "
echo "*******************"
echo "kind: Cluster" >> kind-3nodes.yaml
echo "apiVersion: kind.x-k8s.io/v1alpha4" >> kind-3nodes.yaml
echo "nodes:" >> kind-3nodes.yaml
echo "  - role: control-plane" >> kind-3nodes.yaml
echo "    kubeadmConfigPatches:" >> kind-3nodes.yaml
echo "    - |" >> kind-3nodes.yaml
echo "      kind: InitConfiguration" >> kind-3nodes.yaml
echo "      nodeRegistration:" >> kind-3nodes.yaml
echo "        kubeletExtraArgs:" >> kind-3nodes.yaml
echo "          node-labels: \"ingress-ready=true\"" >> kind-3nodes.yaml
echo "    extraPortMappings:" >> kind-3nodes.yaml
echo "    - containerPort: 80" >> kind-3nodes.yaml
echo "      hostPort: 80" >> kind-3nodes.yaml
echo "      protocol: TCP" >> kind-3nodes.yaml
echo "    - containerPort: 443" >> kind-3nodes.yaml
echo "      hostPort: 443" >> kind-3nodes.yaml
echo "      protocol: TCP" >> kind-3nodes.yaml
echo "  - role: worker" >> kind-3nodes.yaml
echo "  - role: worker" >> kind-3nodes.yaml

kind create cluster --name $1 --config ./kind-3nodes.yaml

echo ""
echo " --> Now, operators/extensions... " 
echo "     ./install-ingress-nginx.sh" 
echo "     ./install-jaeger-operator.sh" 
echo "     ./install-dashboard.sh" 
echo "     ./giveme-token-dashboard.sh" 
echo ""

rm kind-3nodes.yaml



