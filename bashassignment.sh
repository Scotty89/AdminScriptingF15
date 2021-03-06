#!/bin/bash

#this script will install and configure bind
#to serve a private domain

#test if bind exists
#install bind if it does not exist
if [ ! -d /etc/bind ]; then
	echo "Bind is not installed on your system"
	apt-get install bind9
fi

bind='/etc/bind'

#get a domain from user
#complain and exit if domain exists
read -p "Enter the domain name you would like to use: " fqdn

if [ -z $fqdn ]; then
	echo "You didn't enter a domain name."
	exit 2
fi

if [ -e "db.$fqdn" ]; then
	echo "This domain name already exists."
	exit 2
fi

#create and edit a zone file for new domain
soapattern="SOA"
fqdninsert="@	IN	SOA	ns1.$fqdn.	hostmaster.$fqdn.	("

sudo cp "$bind/db.empty" "$bind/db.$fqdn"

cd /etc/bind

sudo sed -i  "/$soapattern/c $fqdninsert" db.$fqdn

echo "You must enter the Serial number"

echo "YYYY=year MM=month DD=day VV=number of edits, all in numbers"

echo "If the number is less than ten put a zero before it"

echo " Example 1989050701"

read -p "Enter the date [YYYYMMDDVV]: " serial

if [ -z $serial ]; then
	echo "You did not enter a serial number."
	exit 2
fi

sudo sed -i "/Serial/c \\\t\t\t$serial\t; Serial" db.$fqdn

host="localhost."
nameserver="@	IN	NS	ns1.$fqdn."
ip="ns1	IN	A	127.0.0.1"
www="www	IN	A	192.168.47.91"
mail="mail	IN	A	192.168.59.5"

sudo sed -i "/$host/c $nameserver" db.$fqdn

sudo sed -i "14 a $ip" db.$fqdn

sudo sed -i "15 a $www" db.$fqdn

sudo sed -i "16 a $mail" db.$fqdn

#create reverse zone files for www and mail
reversewww="192.168.47"
reversemail="192.168.59"
pointerwww="91	IN	PTR	www.$fqdn."
pointermail="5	IN	PTR	mail.$fqdn."

sudo cp "$bind/db.$fqdn" "$bind/db.$reversewww"

sudo sed -i "15,18 d" db.$reversewww

sudo sed -i "14 a $pointerwww" db.$reversewww

sudo cp "$bind/db.$reversewww" "$bind/db.$reversemail"

sudo sed -i "15 d" db.$reversemail

sudo sed -i "14 a $pointermail" db.$reversemail

#add zones to named.conf.local
originzone="zone "$fqdn" {	type master;	file "/etc/bind/db.$fqdn";	allow { 127.0.0.1;	};	};"
mailzone='zone "59.168.192.in-addr.arpa" {	type master;	file "/etc/bind/db.192.168.59";	};'
wwwzone='zone "47.168.192.in-addr.arpa" {	type master;	file "/etc/bind/db.192.168.47";	};'

sudo sed -i "8 a $originzone" named.conf.local

sudo sed -i "10 a $mailzone" named.conf.local

sudo sed -i "12 a $wwwzone" named.conf.local

#reload bind and test that nslookup can find the new names
sudo rndc reload > /dev/null

if [ $? -eq 0 ]; then
	echo "Reloading DNS zones."
else
	echo "Reload of DNS zones failed."
	exit 2
fi

#sleep to allow rndc reload to complete
sleep 3

#test that nslookup can find the new names
nslookup ns1.$fqdn. localhost

if [ $? -eq 0 ]; then
	echo "Looking up ns1.$fqdn."
else
	echo "Look up failed."
	exit 2
fi

nslookup 192.168.47.91 localhost

if [ $? -eq 0 ]; then
	echo "Looking up 192.168.47.91."
else
	echo "Look up failed."
	exit 2
fi

nslookup 192.168.59.5 localhost

if [ $? -eq 0 ]; then
	echo "Looking up 192.168.59.5."
else
	echo "Look up failed."
	exit 2
fi
