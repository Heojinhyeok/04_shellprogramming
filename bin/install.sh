#!/bin/bash

for i in $(seq 1 10)
do
    A=$(expr $i \* 10)
    echo -ne "$A% |"

    ST=1
    while [ $ST -le $i ]
    do
        echo -ne "="
        ST=`expr $ST + 1`
    done

    if [ $i -ne 10 ]; then
        echo -ne ">"
    else
        echo -ne "| complete\n"

    fi
    echo -ne "\r"
    sleep 1

done

