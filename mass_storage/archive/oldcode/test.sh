#!/bin/sh

# SSeeds - 10.6.22

# Simple script checks total number of segments in mass storage (mss) then prompts the user to input the number to send to cache.
 

if [ -f /cache/halla/sbs/raw/e1209019_11219.evio.0.1 ]; then 
    echo "File already exists in cache!"
    #exit 1
fi


test -f /cache/halla/sbs/raw/e1209019_11219.evio.0.1 && echo "$FILE exists."
