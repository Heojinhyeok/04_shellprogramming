#!/bin/bash

LOG=/var/log/messages
TMP1=/tmp/tmp1
TMP2=/tmp/tmp2
TMP3=/tmp/tmp3

egrep -i 'warn|error|fail|crit|alert|emerg' $LOG > $TMP1
while true
do
    sleep 30
    egrep -i 'warn|error|fail|crit|alert|emerg' $LOG > $TMP2
    diff $TMP1 $TMP2 > $TMP3 && continue
    mailx -s "[ WARN ] $LOG check" root < $TMP3
    egrep -i 'warn|error|fail|crit|alert|emerg' $LOG > $TMP1
    
done
