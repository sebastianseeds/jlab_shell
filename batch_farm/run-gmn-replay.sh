#!/bin/bash

#SBATCH --partition=production
#SBATCH --account=halla
#SBATCH --mem-per-cpu=1500

echo 'working directory ='
echo $PWD

#SWIF_JOB_WORK_DIR=$PWD
echo 'swif_job_work_dir='$SWIF_JOB_WORK_DIR

# source login stuff since swif2 completely nukes any sensible default software environment
#source /home/puckett/.cshrc
#source /home/puckett/.login

#echo 'before sourcing environment, env = '
#env 

#module load gcc/9.2.0

#!/bin/bash 

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

#cp $SBS/run_replay_here/.rootrc $PWD

#mkdir -p $PWD/in
#mkdir -p $PWD/rootfiles
#mkdir -p $PWD/logs

#export SBS_REPLAY=/work/halla/sbs/SBS_REPLAY/SBS-replay
export SBS_REPLAY=/work/halla/sbs/seeds/SBS-replay
export DB_DIR=$SBS_REPLAY/DB
# ------
#export PDBFORCE_REPLAY=/work/halla/sbs/pdbforce/SBS-replay
#export DB_DIR=$PDBFORCE_REPLAY/DB
# ------
export DATA_DIR=/cache/mss/halla/sbs/raw

export OUT_DIR=$SWIF_JOB_WORK_DIR
export LOG_DIR=$SWIF_JOB_WORK_DIR

echo 'OUT_DIR='$OUT_DIR
echo 'LOG_DIR='$LOG_DIR
# try this under swif2:
#export DATA_DIR=$PWD
#export OUT_DIR=/volatile/halla/sbs/puckett/GMN_REPLAYS/SBS1_OPTICS/rootfiles
#export LOG_DIR=/volatile/halla/sbs/puckett/GMN_REPLAYS/SBS1_OPTICS/logs
#mkdir -p /volatile/halla/sbs/puckett/GMN_REPLAYS/rootfiles
#mkdir -p /volatile/halla/sbs/puckett/GMN_REPLAYS/logs

#export OUT_DIR=/volatile/halla/sbs/puckett/GMN_REPLAYS/SBS4/rootfiles
#export LOG_DIR=/volatile/halla/sbs/puckett/GMN_REPLAYS/SBS4/rootfiles
#export ANALYZER_CONFIGPATH=$SBS_REPLAY/replay
# ------
export ANALYZER_CONFIGPATH=$SBS_REPLAY/replay
# ------

runnum=$1
maxevents=$2
firstevent=$3

prefix=$4
firstsegment=$5
maxsegments=$6

cp $SBS/run_replay_here/.rootrc $SWIF_JOB_WORK_DIR

#cmd="analyzer -b -q 'replay/replay_BBGEM.C+("$runnum","$firstsegment","$maxsegments")'"

#echo $cmd


analyzer -b -q 'replay_gmn.C+('$runnum','$maxevents','$firstevent','\"$prefix\"','$firstsegment','$maxsegments')'

outfilename=$OUT_DIR'/e1209019_*'$runnum'*.root'
logfilename=$LOG_DIR'/replay_gmn_'$runnum'*.log' 

mv $outfilename /volatile/halla/sbs/pdbforce/gmn-replays/rootfiles
mv $logfilename /volatile/halla/sbs/pdbforce/gmn-replays/logs
