#!/bin/bash

for in $(cat /etc/vsftpd/ftpusers | egrep -v '^#')
do
    echo "$NAME can't access to FTP SERVER"
done