#!/bin/bash

NUM=1
while [ $NUM -le 10 ]
do
	echo -ne "="
    #echo -ne "=\r"
	sleep 1	
	NUM=`expr $NUM + 1`
done