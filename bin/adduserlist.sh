#!/bin/bash

# # cat user.list
# user50 user50
# user51 user51
#...
# user100 user100
START=50
END=100
USERLIST=/root/bin/user.list
> $USERLIST
for i in $(seq $START $END)
do
    #echo $i
    echo "user$i user$i" >> $USERLIST
done