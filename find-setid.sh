#!/bin/bash
# this scirpt lists all the setuid and setgid files in /usr
# the files are displayed using ls -l and sorted by user and group

find /usr -type f -perm -4000 -exec ls -l {} \; | sort -k 3
find /usr -type f -perm -2000 -exec ls -l {} \; | sort -k 4
