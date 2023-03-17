#!/bin/sh

# SSeeds - 1.15.23

# Script checks boolean operators in sh shell scripts

echo "Input a number between 1 and 10. There are two mystery numbers."
read n1

echo $n1 "selected."

if(( $n1==4 ))
then
    echo "You've won because" $n1 "equals one of the mystery numbers (4)."
elif(( $n1==9 ))
then
    echo "You've won because" $n1 "equals one of the mystery numbers (9)."
else
    echo "Wrong guess."
fi
