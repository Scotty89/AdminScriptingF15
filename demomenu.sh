#!/bin/bash

file1="/etc/hosts"
file2="/etc/resolv.conf"
echo "1) $file1"
echo "2) $file2"

read -p "Choose a file by specifying the choice number [press enter to choose neither]: " choice
if [ "$choice" == 1 ]; then
	echo "You chose $file1"
elif [ "$choice" == 2 ]; then
	echo "you chose $file2"
else
	echo "You chose neither file"
fi
