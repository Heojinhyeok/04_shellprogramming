#!/bin/bash

if [ $# -ne 2 ] ; then
    echo "Usage: $0 <pattern> <filename>"
    exit 1
fi

PATTERN=$1
FILE1=$2

# grep -q $PATTERN $FILE1
grep $PATTERN $FILE1 >/dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "[ OK ] 찾았닷~"
else
    echo "[ FAIL ] 못 찾았닷~"
fi