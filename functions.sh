#!/bin/bash

#this script demonstrates doing a function
# the function sets a debug variable to the value passed into it

myDebugValue=56

function error {
	echo "$1" >&2
}

function setDebug {
	echo "Setting debug from $debug to $1"
	debug=$1
}

setDebug $myDebugValue
setDebug 0

error "This is bad"
