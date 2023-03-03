#!/bin/bash

if [ $# -ne 1 ] ; then
    echo "Usage: $0 <U-#>"
    exit 1
fi
CHKNUM1=$1

NUM1=$(echo $CHKNUM1 | awk -F- '{print $2}')
NUM2=$(expr $NUM1 + 1)

FILE1=/root/bin/report.txt

sed -n "/U-$NUM1/,/U-$NUM2/p" $FILE1 | grep -v "U-$NUM2"
