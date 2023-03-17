#!/bin/sh

# SSeeds - 10.6.22

# Script checks total number of segments in mass storage (mss) then prompts the user to input the number to send to cache.

echo "Which experiment are we talking about? Enter 9 if GMn or 6 if GEn."
read exp

echo $exp "selected."

echo "Which run are we interested in?" 
read run

echo $run "selected."

if(( $exp==6 ))
then
    #echo $exp $exp=6
    for (( stream=0; stream<3; stream++ ))
    do
    ls /mss/halla/sbs/GEnII/raw/e120901$exp\_$run.evio.$stream.* | sort -V | tail -n1
    done

elif(( $exp==9 ))
then
    ls /mss/halla/sbs/raw/e120901$exp\_$run.evio.0.* | sort -V | tail -n1
else
    echo "Invalid experiment entry."
    exit 1
fi

echo "Final segment for each stream reported above. So, how many segments shall we cache?"
read seg

# Check to see if the segment already exists in cache then cache all streams
if(( $exp==6 ))
then
    if(( -f /cache/halla/sbs/GEnII/raw/e120901$exp\_$run.evio.0.$seg ))
    then 
	echo "Warning: File already exists in cache."
    fi
    
    for (( stream=0; stream<3; stream++ ))
    do
	for (( i=0; i<=$seg; i++ ))
	do
	    jcache get /mss/halla/sbs/GEnII/raw/e120901$exp\_$run.evio.$stream.$i
	    sleep 5s
	done
    done

elif(( $exp==9 ))
then
    if(( -f /cache/halla/sbs/raw/e120901$exp\_$run.evio.0.$seg ))
    then 
	echo "File already exists in cache!"
	exit 1
    fi
    for (( i=0; i<=$seg; i++ ))
    do
	jcache get /mss/halla/sbs/raw/e120901$exp\_$run.evio.0.$i
	sleep 5s
    done
    
fi

echo "Done!"

