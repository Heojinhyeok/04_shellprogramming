#!/bin/bash

if [ $# -ne 1 ] ; then
    echo "Usage: $0 <filename>"
    exit 2
fi
FILE1="$1"

FILESIZE=$(wc -c < "$FILE1")
# echo $FILESIZE

if [ $FILESIZE -ge 5120 ] ; then
    echo "너무 큰  파일입니다.: $FILESIZE bytes"
else
    echo "너무 작은 파일입니다.: $FILESIZE bytes"
fi
