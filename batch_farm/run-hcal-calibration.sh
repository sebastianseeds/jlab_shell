#!/bin/bash

#SBATCH --partition=production
#SBATCH --account=halla
#SBATCH --mem-per-cpu=1500

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

module load gcc/9.2.0 

source /site/12gev_phys/softenv.sh 2.4

ldd /work/halla/sbs/ANALYZER/install/bin/analyzer |& grep not

echo 'working directory = '$PWD

export ANALYZER=/work/halla/sbs/ANALYZER/install
source $ANALYZER/bin/setup.sh
source /work/halla/sbs/SBS_OFFLINE/install/bin/sbsenv.sh

export HCAL_REPLAY=/w/halla-scshelf2102/sbs/seeds/HCal_replay
export CONFIG_DIR=$HCAL_REPLAY/macros/Combined_macros/cfg
export GAIN_DIR=$HCAL_REPLAY/macros/Gain
export HIST_DIR=$HCAL_REPLAY/macros/hist
export RunList_DIR=$HCAL_REPLAY/macros/Run_list

export OUT_DIR=$SWIF_JOB_WORK_DIR
export LOG_DIR=$SWIF_JOB_WORK_DIR

echo 'OUT_DIR='$OUT_DIR
echo 'LOG_DIR='$LOG_DIR

export ANALYZER_CONFIGPATH=$SBS_REPLAY/replay

setnum=$1
iter=$2
configfile=$3

cp $HCAL_REPLAY/scripts/.rootrc $SWIF_JOB_WORK_DIR

# analyzer -b -q 'replay_gmn.C+('$runnum','$maxevents','$firstevent','\"$prefix\"','$firstsegment','$maxsegments')'

analyzer -b -q 'HCalECal_v3.C('\"$CONFIG_DIR/$3\"','$iter')'

outfile1=$OUT_DIR'/eng_cal_gainCoeff_sh_'$setnum'_'$iter'.txt'
outfile2=$OUT_DIR'/eng_cal_gainRatio_sh_'$setnum'_'$iter'.txt'
outfile3=$OUT_DIR'/eng_cal_gainCoeff_ps_'$setnum'_'$iter'.txt'
outfile4=$OUT_DIR'/eng_cal_gainRatio_ps_'$setnum'_'$iter'.txt'
outhist=$OUT_DIR'/eng_cal_BBCal_'$setnum'_'$iter'.root'

mv $outfile1 $GAIN_DIR
mv $outfile2 $GAIN_DIR
mv $outfile3 $GAIN_DIR
mv $outfile4 $GAIN_DIR
mv $outhist $HIST_DIR

