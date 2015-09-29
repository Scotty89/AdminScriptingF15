#!/bin/bash
# this scirpt lists all the setuid and setgid files in /usr
# the files are displayed using ls -l and sorted by user and group

echo
echo "These files are set-uid"
echo "======================="
find /usr -type f -perm -4000 -exec ls -l {} \; | sort -k 3

echo
echo "These files are set-gid"
echo "======================="
find /usr -type f -perm -2000 -exec ls -l {} \; | sort -k 4
echo
