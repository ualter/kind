#!/bin/bash

clear
#if [ -z "$1" ]; then
#	echo "ERROR! Please inform Cluster Name"
#	echo ""
#	exit
#fi

echo ""
echo "--> There you go..." 
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
echo ""
