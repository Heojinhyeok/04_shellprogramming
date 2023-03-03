#!/bin/bash

# svc.sh start sshd
# ->systemctl enable sshd
# ->systemctl restart sshd
# ->systemctl status sshd
# svc.sh stop sshd
# ->systemctl disable sshd
# ->systemctl stop sshd
# ->systemctl status sshd


if [ $# -ne 2 ]; then
    echo "Usage: $0 <start|stop> <service>"
    exit 1
fi
SCRIPTNAME=$0
ACTION=$1
SVC=$2

SVC_START() {
    systemctl enable $SVC >/dev/null 2>&1
    if [ $? -eq 0 ] ; then
        systemctl restart $SVC
        systemctl status $SVC
    else    
        echo "[ FAIL ] 서비스 이름을 알수 없습니다."
        exit 3

    fi
}

SVC_STOP() {
    systemctl disable $SVC >/dev/null 2>&1
    if [ $? -eq 0 ] ; then
        systemctl stop $SVC
        systemctl status $SVC
    else
        echo "[ FAIL ] 서비스 이름을 알수 없습니다."
        exit 4
    fi
}

ERR_1() {
    echo "Usage: $SCRIPTNAME <start|stop> <service>"
    exit 5
}
case $ACTION in
    start) SVC_START ;;
    stop) SVC_STOP ;;
    *) ERR_1 ; exit 2;;

esac

