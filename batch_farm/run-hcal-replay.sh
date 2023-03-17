#!/bin/bash

echo 'working directory ='
echo $PWD

echo 'swif_job_work_dir='$SWIF_JOB_WORK_DIR

MODULES=/etc/profile.d/modules.sh 

if [[ $(type -t module) != function && -r ${MODULES} ]]; then 
source ${MODULES} 
fi 

if [ -d /apps/modulefiles ]; then 
module use /apps/modulefiles 
fi 

source /site/12gev_phys/softenv.sh 2.5
module load gcc/9.2.0 
ldd /work/halla/sbs/seeds/ANALYZER/install/bin/analyzer |& grep not

export ANALYZER=/work/halla/sbs/seeds/ANALYZER/install
source $ANALYZER/bin/setup.sh
source /work/halla/sbs/seeds/SBS_OFFLINE/install/bin/sbsenv.sh

export SBS_REPLAY=/work/halla/sbs/seeds/SBS-replay
export DB_DIR=$SBS_REPLAY/DB

export DATA_DIR=/cache/mss/halla/sbs/raw

export OUT_DIR=$SWIF_JOB_WORK_DIR
export LOG_DIR=$SWIF_JOB_WORK_DIR

echo 'OUT_DIR='$OUT_DIR
echo 'LOG_DIR='$LOG_DIR

export ANALYZER_CONFIGPATH=$SBS_REPLAY/replay

runnum=$1
maxevents=$2
firstevent=$3

prefix=$4
firstsegment=$5
maxsegments=$6

cp $SBS/run_replay_here/.rootrc $SWIF_JOB_WORK_DIR

analyzer -b -q 'replay_hcal_GMn.C+('$runnum','$maxevents','$firstevent','\"$prefix\"','$firstsegment','$maxsegments')'

outfilename=$OUT_DIR'/hcal_gmn_*'$runnum'*.root'
logfilename=$LOG_DIR'/replay_gmn_'$runnum'*.log' 

mv $outfilename /volatile/halla/sbs/seeds/rootfiles
mv $logfilename /volatile/halla/sbs/seeds/logs
