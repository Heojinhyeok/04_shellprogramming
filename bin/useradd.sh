#!/bin/bash
# # useradd user01
# # echo $USER | useradd --stdin $UNAME

FILE=/root/bin/user.list
cat $FILE | while read UNAME UPASS

do
    echo "$UNAME : $UPASS "
    useradd $UNAME
    echo $UPASS | useradd --stdin $UNAME >/dev/null 2>&1
    echo "[ OK ] $UNMAE"
done