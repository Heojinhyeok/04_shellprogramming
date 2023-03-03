#!/bin/bash

echo -n "파일이름을 입력하세요 :"
read FILE1

# echo $FILE1

if [ -x $FILE1 ] ; then
    eval $FILE1
fi

# [ -x $FILE1] && eval $FILE1