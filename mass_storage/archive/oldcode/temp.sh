#!/bin/sh

# SSeeds - 10.6.22

# Simple script checks total number of segments in mass storage (mss) then prompts the user to input the number to send to cache.

echo "And which experiment? Enter 9 if GMn or 6 if GEn."
read exp

echo "Which run are we interested in?" 
read run

if [ exp==$6 ]
then

    for (( stream=0; stream<3; s++ ))
    
    ls /mss/halla/sbs/GEnII/

    ls /mss/halla/sbs/GEnII/raw/e120901$exp\_$run.evio.$stream.*
    done

elif [ exp==$9 ]

    /mss/halla/sbs/raw/e120901$exp\_$run.evio.0.*

else
    echo "Invalid experiment entry."
    exit 1
fi

echo "Final segment for each stream reported above. So, how many segments shall we cache?"
read seg

# Check to see if the segment already exists in cache then cache all streams
if [ exp==$6 ]
then

    if [ -f /cache/halla/sbs/GEnII/raw/e120901$exp\_$run.evio.0.$seg ]
    then 
	echo "Warning: File already exists in cache."
    fi
    
    for (( stream=0; stream<3; s++ ))
    do
	for (( i=0; i<=$seg; i++ ))
	do
	    jcache get /mss/halla/sbs/GEnII/raw/e120901$exp\_$run.evio.$stream.$i
	    sleep 5s
	done
    done

elif [ exp==$9 ]

    if [ -f /cache/halla/sbs/raw/e120901$exp\_$run.evio.0.$seg ]
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




#for (( i=0; i<=$seg; i++ ))
#do
#    jcache get /mss/halla/sbs/GEnII/raw/e120901$exp\_$run.evio.0.$i
#    sleep 5s
#done

echo "Done!"

#run=$1
#segments=$2

#echo -e "\n Requesting cache of $2 segments of run $1... \n"

#for (( i=0; i<=$2; i++ ))
#do
    #echo "$i"
#    jcache get /mss/halla/sbs/raw/e1209019_$1.evio.0.$i
#    sleep 5s
#done
