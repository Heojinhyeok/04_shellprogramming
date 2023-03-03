#!/bin/bash

IP1=172.16.6.8
PORT=21

ftp -n $IP1 $PORT << EOF
user user01 user01
cd share
lcd /test
bin
hash
promtp
mput pv1.txt
quit
EOF