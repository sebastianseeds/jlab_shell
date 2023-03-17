#!/bin/bash

#sseeds 3.16.23 update: made changes to accomodate MC database with optics and momentum calibration by kinematic. Still only works for GMn. Also includes quality of life improvements, but expects g4sbs macro naming convention of the kind: gmn_sbs9_ld2_70p.mac for gmn experiment, ld2 target, 70% SBS field. Be sure to have this file configured and ready where g4sbs can see it.

kine=$1 #kinematic {4, 7, 11, 14, 8, 9}
tar=$2 #target {lh2, ld2}
field=$3 #sbs magnetic field percent 
nevents=$4 #number of events per job {0, 30, 50, 70, 85, 100}
njobs=$5 #number of jobs
preinit='gmn_sbs'$kine'_'$tar'_'$field'p'
workflowname='seeds_gmnMCreplay_sbs'$kine'_'$tar'_'$field'p'
swif2 create $workflowname
# specify a directory on volatile to store g4sbs, sbsdig, & replayed files.
# Working on a single directory is convenient safe for the above mentioned
# three processes to run smoothly.
outdirpath='/lustre19/expphy/volatile/halla/sbs/seeds/simulation'

# Valid targets
vt1="lh2"
vt2="ld2"

# Validating target parameter is correct
if [[ $tar != $vt1 ]] && [[ $tar != $vt2 ]]; then
    echo -e "\n--!--\n Error: Target parameter should either be lh2 or ld2."
    exit;
fi

# Validating the number of arguments provided
if [[ "$#" -ne 5 ]]; then
    echo -e "\n--!--\n Error: Incorrect number of arguments."
    echo -e "Script expecting 5 arguments: <kinematic> <target> <field> <nevents> <njobs> \n"
    exit;
fi

for ((i=1; i<=$njobs; i++))
do
    # lets submit g4sbs jobs first
    outfilename=$preinit'_job_'$i'.root'
    postscript=$preinit'_job_'$i'.mac'
    g4sbsjobname=$preinit'_job_'$i

    g4sbsscript='/work/halla/sbs/seeds/shell/batch_farm/run-g4sbs-simu.sh'

    swif2 add-job -workflow $workflowname -partition production -name $g4sbsjobname -cores 1 -disk 5GB -ram 1500MB $g4sbsscript $preinit $postscript $nevents $outfilename $outdirpath

    # now, it's time for digitization
    txtfile=$preinit'_job_'$i'.txt'
    sbsdigjobname=$preinit'_digi_job_'$i
    sbsdiginfile=$outdirpath'/'$outfilename

    sbsdigscript='/work/halla/sbs/seeds/shell/batch_farm/run-sbsdig.sh'
    
    swif2 add-job -workflow $workflowname -antecedent $g4sbsjobname -partition production -name $sbsdigjobname -cores 1 -disk 5GB -ram 1500MB $sbsdigscript $txtfile $sbsdiginfile

    # finally, lets replay the digitized data
    digireplayinfile=$preinit'_job_'$i
    digireplayjobname=$preinit'_digi_replay_job_'$i

    digireplayscript='/work/halla/sbs/seeds/shell/batch_farm/run-digi-replay.sh'
    
    swif2 add-job -workflow $workflowname -antecedent $sbsdigjobname -partition production -name $digireplayjobname -cores 1 -disk 5GB -ram 1500MB $digireplayscript $digireplayinfile $outdirpath $kine
done

# run the workflow and then print status
swif2 run $workflowname
echo -e "\n Getting workflow status.. [may take a few minutes!] \n"
swif2 status $workflowname
