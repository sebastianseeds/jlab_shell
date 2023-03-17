#!/bin/bash

preinit=$1 # don't add file extension
nevents=$2
njobs=$3
workflowname='seeds_gmn_sbs4_ld2_50p'
swif2 create $workflowname
outdirpath='/lustre19/expphy/volatile/halla/sbs/seeds/simulation'

# Validating the number of arguments provided
if [[ "$#" -ne 3 ]]; then
    echo -e "\n--!--\n Illegal number of arguments!!"
    echo -e " This script expects 3 arguments: <preinit> <nevents> <njobs> \n"
    exit;
fi

for ((i=1; i<=$3; i++))
do
    outfilename=$preinit'_job_'$i'.root'
    postscript=$preinit'_job_'$i'.mac'
    jobname=$preinit'_job_'$i

    script='/work/halla/sbs/seeds/shell/batch_farm/run-g4sbs-simu.sh'

    swif2 add-job -workflow $workflowname -partition production -name $jobname -cores 1 -disk 5GB -ram 1500MB $script $preinit $postscript $nevents $outfilename $outdirpath
    #./run-g4sbs-simu.sh $preinit $postscript $nevents $outfilename $outdirpath # for testing purposes
done

# run the workflow and then print status
swif2 run $workflowname
echo -e "\n Getting workflow status.. [may take a few minutes!] \n"
swif2 status $workflowname
