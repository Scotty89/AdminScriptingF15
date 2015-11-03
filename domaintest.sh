#!/bin/bash
read -p "enter a domain name: " fqdn
if [ -e "db.$fqdn" ]; then
	echo "the domain exists"
else 
	echo "the domain is available"
fi
