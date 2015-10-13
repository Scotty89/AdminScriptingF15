#!/bin/bash

#this script shows a summary of how many processes are running by username
# it also warns you if a process is running under nobody

declare -A myProcs

for currentprocessuser in `ps -eo user|tail -n +2`; do
	myProcs[$currentprocessuser]=$(( ${myProcs[$currentprocessuser]} + 1 ))
done

for user in ${!myProcs[@]}; do 
	echo "User $user has ${myProcs[$user]} processes running"
done

if [[ "${myProcs[nobody]}" -gt 0 ]]; then
	echo "User nobody has processes!"
fi
