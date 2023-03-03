#!/bin/bash
# # cat hosts.txt
# 192.168.10.10 server10.example.com
# 192.168.10.20 server11.example.com
# ...
# 192.168.10.30 server30.example.com

HOSTS=/etc/hosts
# HOSTS=/root/bin/hosts && > $HOSTS
NET=192.168.10
START=10
END=30

C_IP=$(ip addr show ens33 | grep -w inet | awk '{print $2}' | awk -F. '{print $4}' | awk -F/ '{print $1}')

for i in $(seq $START $END)
do
    [ $C_IP -eq $i ] && continue
   # echo $i
   echo "$NET.$i server$i.example.com server$i" >> $HOSTS 
done
