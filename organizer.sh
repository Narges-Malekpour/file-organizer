#!/bin/bash

read -p "Please enter the directory path: " dir_path

if [ ! -d "$dir_path" ] ;then
	echo "Error.. The "$dir_path" directory does not exist"
	exit 1
fi

echo "Directory found! Proceeding to organize..."

