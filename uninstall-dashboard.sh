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
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc6/aio/deploy/recommended.yaml

echo ""

