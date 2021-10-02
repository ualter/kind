#!/bin/bash

clear
#if [ -z "$1" ]; then
#	echo "ERROR! Please inform Cluster Name"
#	echo ""
#	exit
#fi

echo ""
echo "************************"
echo " Uninstalling Dashboard "
echo "************************"
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml

echo ""

