#!/bin/bash
# This script performs a number of tasks with input from the user


# Variables
auto="Off"
debug=0

# Functions
source myfuncs.bash

# This function shows our usage help to the user
function usage {
	programName=`basename $0`
	echo "Usage: $programName [-h|--help] [-d|--debug level] [-a|--auto] directory 1 directory2"
}

# Command Line Processing
while [ $# -gt 0 ]; do
	case "$1" in
		-h | --help )
			usage
			exit
			;;
		-a | --auto )
			auto="On"
			;;
		-d | --debug )
			if [ -z "$2" ]; then
				error-message "You didn't specify a debug level for the debug option"
				exit 2
			else
				setDebug "$2"
				shift
			fi
			;;
		* )
			if [ ! -v dir1 ]; then
				dir1="$1"
			elif [ ! -v dir2 ]; then
				dir2="$1"
			else
				error-message "I don't understand '$1'"
				exit 2
			fi
			;;
	esac
	shift
done

# Command Line Validation
if [ ! -v dir1 ]; then
	read -p "Directory 1? " dir1
	read -p "Directory 2? "	dir2
elif [ ! -v dir2 ]; then
	read -p "Directory 2? "	dir2
fi

if [ ! -d "$dir1" ]; then
	error-exit "Directory '$dir1' does not exist"
fi
if [ ! -d "$dir2" ]; then
	error-exit "Directory '$dir2' does not exist"
fi
if [ "$dir1" == "$dir2" ]; then
	error-exit "The two directories must not be the same"
fi

# Main
echo "auto is set to $auto"
echo "debug is set to $debug"
echo "Directory 1 is set to '$dir1'"
echo "Directory 2 is set to '$dir2'"

dir1space=`du -sk "$dir1"|cut -d\	 -f 1`
dir2space=`du -sk "$dir2"|cut -d\	 -f 1`

if [ $dir1space -gt $dir2space ]; then
	filecount=`find "$dir1" -type f|wc -l`
	dircount=`find "$dir1" -type d|wc -l`
	cat <<EOF
$dir1 uses the most space
It has $filecount regular files in $dircount directories using $dir1space KB
EOF
elif [ $dir2space -gt $dir1space ]; then
	filecount=`find "$dir2" -type f|wc -l`
	dircount=`find "$dir2" -type d|wc -l`
	cat <<EOF
$dir2 uses the most space
It has $filecount regular files in $dircount directories using $dir2space KB
EOF
else
	filecount=`find "$dir1" -type f|wc -l`
	dircount=`find "$dir1" -type d|wc -l`
	file2count=`find "$dir2" -type f|wc -l`
	dir2count=`find "$dir2" -type d|wc -l`
	cat <<EOF
Both directories use $dir1space KB
$dir1 has $filecount files in $dircount directories
$dir2 has $file2count files in $dir2count directories
EOF
	
fi
