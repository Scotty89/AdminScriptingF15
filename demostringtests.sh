#!/bin/bash

if [ -v SHELL ]; then
	echo "The variable SHELL exists"
else
	echo "The variable SHELL does not exist"
fi

if [ -v FLOOBLE ]; then
	echo "The variable FLOOBLE exists"
else
	echo "The variable FLOOBLE does not exist"
fi

if [ -n "$USER" ]; then
	echo "The variable USER has '$USER' in it"
else
	echo "The variable USER does not have anything in it or does not exist"
fi

if [ -n "$FLOOBLE" ]; then
	echo "The variable FLOOBLE has '$FLOOBLE' in it"
else
	echo "The variable FLOOBLE does not have anything in it or does not exist"
fi

a=1
b=01
c=02
if [ "$a" == "$b" ]; then
	echo "$a is alphanumerically equal to $b"
else
	echo "$a is not alphanumerically equal to $b"
fi
if [ $a -eq $b ]; then
	echo "$a is numerically equal to $b"
else
	echo "$a is not numerically equal to $b"
fi

if [ $a -le $c ]; then
	echo "In numerical order, we have $a then $c"
else
	echo "In numerical order, we have $c then $a"
fi
if [ "$a" \< "$c" ]; then
	echo "In alphanumerical order, we have $a then $c"
else
	echo "In alphanumerical order, we have $c then $a"
fi

arr=(a b c d)
if [ ${#arr[@]} -gt 1 ]; then
	echo "arr has more than one element"
elif [ ${#arr[@]} -eq 1 ]; then
        echo "arr has one element"
else
	echo "arr has no elements"
fi
