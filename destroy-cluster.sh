#!/bin/bash

clear
if [ -z "$1" ]; then
	echo "ERROR! Please inform Cluster Name"
	echo ""
	exit
fi

echo ""
echo "**********************"
echo " Destroying Cluster   " 
echo "**********************"
kind delete cluster --name $1





