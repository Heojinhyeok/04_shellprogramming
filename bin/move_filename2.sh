#!/bin/bash

if [ $# -ne 1 ] ; then
    echo "Usage: $0 <Directory>"
    exit 1
fi

D_WORK=$1

SRC_EXT='.txt$'
DST_EXT='.els'

T_FILE1=/tmp/.tmp1

ls -1 $D_WORK | grep "$SRC_EXT" > $T_FILE1
for FILE in `cat $T_FILE1`
do
    mv $D_WORK/$FILE $(echo $D_WORK/$FILE | sed "s/$SRC_EXT/$DST_EXT/g")
done