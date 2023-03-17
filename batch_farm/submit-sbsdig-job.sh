#!/bin/bash

inputfile=$1 # .txt file containing input file paths
jobname=$2
outdirpath='/lustre19/expphy/volatile/halla/sbs/seeds/simulation'

script='/work/halla/sbs/seeds/batch_farm/run-sbsdig.sh'

swif2 add-job -workflow test-g4sbs -partition production -name $jobname -cores 1 -disk 5GB -ram 1500MB $script $inputfile $outdirpath

#$script $inputfile $outdirpath # for testing purposes
