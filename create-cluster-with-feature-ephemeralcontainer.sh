#!/bin/sh

clear
if [ -z "$1" ]; then
	echo "ERROR! Please inform Cluster Name"
	echo ""
	exit
fi

echo ""
echo "******************************"
echo " Creating Cluster $1"
echo "******************************"
cat <<EOF | kind create cluster --name $1 --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
featureGates:
  EphemeralContainers: true
nodes:
  - role: control-plane
    kubeadmConfigPatches:
    - |
      kind: InitConfiguration
      nodeRegistration:
        kubeletExtraArgs:
          node-labels: "ingress-ready=true"
    extraPortMappings:
    - containerPort: 80
      hostPort: 80
      protocol: TCP
    - containerPort: 443
      hostPort: 443
      protocol: TCP
  - role: worker
  - role: worker
EOF
