#!/bin/bash

clear
#if [ -z "$1" ]; then
#	echo "ERROR! Please inform Cluster Name"
#	echo ""
#	exit
#fi

echo ""
echo "**********************"
echo " Installing Dashboard "
echo "**********************"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc6/aio/deploy/recommended.yaml


echo ""
echo "--> All K8s workloads created"
kubectl get all -n kubernetes-dashboard
echo ""
echo "--> ServiceAccount to acces the Dashboard" 
kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF

# Create a ClusterRoleBinding for the ServiceAccount
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

echo ""
echo "--> Wait some seconds to start completely..." 
kubectl wait --namespace kubernetes-dashboard \
  --for=condition=ready pod \
  --selector=k8s-app=kubernetes-dashboard \
  --timeout=90s

echo ""
echo "Ok! ready..."
echo "http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
echo ""
echo ""
echo "--> Here you have it, the Access Token... " 
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
echo ""
echo ""
echo "[CTRL + C] to stop it, and 'kubectl proxy' to get it available again..."
echo ""
kubectl proxy  
echo ""
