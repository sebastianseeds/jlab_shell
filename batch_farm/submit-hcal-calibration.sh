#!/bin/bash

# submit calibration jobs

setnum=$1
iter=$2
prefix=$3

jobname=$prefix-$iter
configfile=$prefix.cfg

script='/work/halla/sbs/seeds/batch_farm/run-hcal-calibration.sh'

swif2 add-job -workflow bbcal-calib-sbs14 -partition production -name hcal-calib-$jobname -cores 1 -disk 25GB -ram 1500MB  $script $setnum $iter $configfile

#Example: ./submit-hcal-calibration.sh 2 1 sbs4_LD2_50mag ##SBS4,SBS50%,1st iter
