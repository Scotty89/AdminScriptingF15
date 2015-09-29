#!/bin/bash
#mybackup.sh
#This script copies the directory my data in my home directory

cd ~/mydata
mkdir ~/mydata-backup
tar cvf - .| (cd ~/mydata-backup; tar xf-)
