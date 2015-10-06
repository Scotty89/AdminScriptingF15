#!/bin/bash
#this script demonsstrates doing arithmetic

#get two numbers from user
read -p "Enter a number please: " firstnum
read -p "Enter another number please: " secondnum

#do some arithmetic
sum=$((firstnum+secondnum))
echo "$firstnum plus $secondnum is $sum"
sum=$((firstnum-secondnum))
echo "$firstnum minus $secondnum is $sum"
sum=$((firstnum*secondnum))
echo "$firstnum times $secondnum is $sum"
sum=$((firstnum/secondnum))
echo "$firstnum divided by $secondnum is $sum"
sum=$((firstnum%secondnum))
echo "$firstnum divided by $secondnum leaves a remainder of $sum"
