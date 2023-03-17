#!/bin/bash

#Basic script to test how the farm does things

echo Checking shell script against user input $1

if [ $1 -gt 5 ]
then
    echo Number is too large
    
elif [ $1 -eq 1 ]
then
    echo Number is 1
    
elif [ $1 -eq 2 ]
then
    echo Number is 2
    
elif [ $1 -eq 3 ]
then
    echo Number is 3
    
elif [ $1 -eq 4 ]
then
    echo Number is 4
    
elif [ $1 -eq 5 ]
then
    echo Number is 5
    
else
    echo Number is less than 1

fi


