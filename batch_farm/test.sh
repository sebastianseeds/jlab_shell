#!/bin/bash

kine=$1
tar=$2
field=$3
nevents=$2
njobs=$3
preinit='gmn_sbs'$kine'_'$tar'_'$field'p'

tar1="lh2"
tar2="ld2"

if [[ $tar != $tar1 ]] && [[ $tar != $tar2 ]]; then
    echo -e 'derpFAIL'
fi

export DB_DIR=$SBS_REPLAY/DB_MCkin/SBS$kine

echo -e $preinit $DB_DIR
