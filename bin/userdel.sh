#!/bin/bash
# # userdel user01

FILE=/root/bin/user.list
cat $FILE | while read UNAME UPASS

do
    userdel -r $UNAME
    echo "[ OK ] $UNMAE"
done

