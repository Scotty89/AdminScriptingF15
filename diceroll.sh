#!/bin/bash

#this script will generate a roll of a specified number of dice
#and print out a summary of the roll

count=2 #default of 2 dice
sides=6 #default of 6 sides

if [ $# -ne 2 ]; then
	echo "You didn't give me a count of dice and number of sides per die"
	echo "Using the defaults of $count dice with $sides sides each"
else 
	count="$1"
	if [[ "$count" -lt 1 || "$count" -gt 50 ]]; then
		echo "Invalid count of dice, keept it between 2 and 50."
		exit 2
	fi
	sides="$2"
	if [[ "$sides" -lt 3 || "$sides" -gt 20 ]]; then
		echo "Invalid count of sides, keep it between 3 and 20."
		exit 2
	fi
fi

sum=0
while [ $count -gt 0 ]; do
	roll=$(( $RANDOM % $sides + 1 ))
	sum=$(( $sum + $roll ))
	echo "Rolled $roll"
	count=$((count - 1))
done
echo "You rolled a total of $sum"
