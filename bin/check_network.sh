#!/bin/bash

. /root/bin/functions.sh

# (1) Local Network Connection
# (2) External Network Connection
# (3) DNS Client Configuration

IP1=192.168.10.2
IP2=8.8.8.8
IP3=www.google.com

# (1) Local Network Connection
print_info "(1) ping $IP1"
ping -c 2 $IP1 -w 2 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "Local Network Connection"
else
    print_error "Local Network Connection"
    echo "(a) 물리적인 연결 확인"
    echo "  # ethtool <NIC>"
    echo "(b) IP/NETMASK"
    echo "  # ip addr"
    echo "(c) VMware VMnet8 설정"
    echo "  VMware > Edit > Virtaul Network Editor > VMnet8 > 192.168.10.0/255.255.255.0"
    echo "(d) VMware 서비스 확인"
    echo "  services.msc > VMware* 확인"
fi

# (2) External Network Connection
print_info "(2) ping $IP2"
ping -c 2 $IP2 -w 2 >/dev/null 2>&1

if [ $? -eq 0 ]; then
    print_good "External Network Connection"
else
    print_error "External Network Connection"
    echo "(a) ip route (netstat -nr)"

fi
# (3) DNS Client Configuration
print_info "(3) ping $IP3"
ping -c 2 $IP3 -w 2 >/dev/null 2>&1

if [ $? -eq 0 ]; then
    print_good "DNS Client Configuration"
else
    print_error "DNS Client Configurationn"
    echo "(a) /etc/resolv.conf"

fi