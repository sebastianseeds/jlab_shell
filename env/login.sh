
# ident  "@(#).login     ver 1.0     Aug 20, 1996"
# Default user .login file.
#
# This file is executed after ~/.cshrc at login.
# This file should contain commands that set the options 
# for a terminal and/or window and commands that are
# only needed during an interactive session.


#####
# Source the site-wide syslogin and sysapps files. 
# The syslogin file displays motd and notifies users of
# news and mail during login.  The sysapps file sets up
# the user's environment for commonly used applications.
# These lines should not be deleted.
#####
source /site/env/syslogin
source /site/env/sysapps


#####
# Set up the terminal.
# The stty command sets certain terminal I/O options
# for the device that is the current standard input.
# The lines below define the actions of the keys on
# different keyboardsi (ie. delete and backspacce).
#####
# Uncomment this if you are using an NCD Xterminal keyboard.
stty erase "^?" kill "^U" intr "^C" eof "^D" susp "^Z" hupcl ixon ixoff tostop tabs


#####
# Define the string that will prompt you for interactive input.
# You may pick one or define your own.  Only one should be uncommented.
#####
set prompt = "`hostname`> "          # Name of the machine you are on.
#set prompt = "`hostname`[\!] "       # Name of the machine and history number
#set prompt = "`whoami`> "            # Your user name.
#set prompt = "`whoami`[\!] "         # Your user name and history number


#####
# Defines the LINES fand COLUMNS environment variables for users
# using the tcsh.  This is a workaround for a bug in the tcsh. 
#####
if ($?tcsh) then
   setenv LINES ""
   setenv COLUMNS ""
endif

#############################################
#Several environments are needed for analysis
#############################################
setenv JLAB_ROOT /site/12gev_phys

#G4SBS and Analyzer converge on 2.5
setenv JLAB_VERSION 2.5
source $JLAB_ROOT/softenv.csh $JLAB_VERSION
module load gcc/9.2.0  

#SIMC environment (should almost always be commented)
#setup cernlib/2005
#source /site/12gev_phys/2.3/Linux_CentOS7.2.1511-x86_64-gcc4.8.5/root/6.14.04/bin/thisroot.csh

#############################
#Set up static user variables
#############################

#setenv PATH ${PATH}:/apps/cmake/PRO/bin:/w/halla-scshelf2102/sbs/seeds/sbs_devel/install/bin:/w/halla-scshelf2102/sbs/seeds/sbs_devel/install/include

setenv PATH /apps/cmake/PRO/bin:${PATH}

#setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/w/halla-scshelf2102/sbs/seeds/ANALYZER/install/lib64
setenv SWIF_JOB_WORK_DIR /volatile/halla/sbs/seeds/rootfiles

#setenv SEEDS /w/halla-scshelf2102/sbs/seeds
setenv ANALYZER /work/halla/sbs/seeds/ANALYZER/install
setenv LD_LIBRARY_PATH $ANALYZER/install/lib64:${LD_LIBRARY_PATH}
#setenv DATA_DIR /lustre19/expphy/cache/halla/sbs/raw
setenv ROOTFILES /volatile/halla/sbs/seeds/rootfiles
#setenv L_DIR /w/halla-scshelf2102/sbs/seeds/HCal_replay/replay
setenv OUT_DIR /volatile/halla/sbs/seeds/rootfiles
setenv LIBSBSDIG /work/halla/sbs/seeds/dig/install
setenv SBSOFFLINE /work/halla/sbs/seeds/SBS_OFFLINE/install
#setenv HCAL /w/halla-scshelf2102/sbs/seeds/HCal_replay
#setenv BBCAL /w/halla-scshelf2102/sbs/seeds/BBCal_calibration
setenv HCAL_REPLAY /work/halla/sbs/seeds/HCAL-replay
setenv SBS_REPLAY /work/halla/sbs/seeds/SBS-replay
setenv DB_DIR $SBS_REPLAY/DB
#setenv ROOTFILES /volatile/halla/sbs/seeds/rootfiles
#setenv OUTFILES /w/halla-scshelf2102/sbs/seeds/outFiles
#setenv GRINCH /w/halla-scshelf2102/sbs/seeds/Grinch
setenv SIM /w/halla-scshelf2102/sbs/seeds/sim/install
setenv ANALYZER_CONFIGPATH $SBS_REPLAY/replay
setenv LOG_DIR /volatile/halla/sbs/seeds/logs
setenv CONFIG_DIR /w/halla-scshelf2102/sbs/seeds/HCal_replay/hcal/configs

source ${ANALYZER}/bin/setup.csh
source ${SBSOFFLINE}/bin/sbsenv.csh
source ${SIM}/bin/g4sbs.csh
source ${LIBSBSDIG}/bin/sbsdigenv.csh
#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
