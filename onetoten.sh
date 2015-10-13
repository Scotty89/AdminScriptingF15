#!/bin/bash

#this script asks the user for a number between 1 and 10
#and continues to ask until the user gets it right

myNumber=$(($RANDOM % 10 + 1))

guess=0
while [ $guess -ne $myNumber ]; do
	read -p "Pick a number from 1 to 10: "  guess
done

echo "You got it!"

