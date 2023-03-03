#!/bin/bash

# 1. PV
# 2. VG
# 3. LV
TMP1=/tmp/tmp1
TMP2=/tmp/tmp2
TMP3=/tmp/tmp3
TMP4=/tmp/tmp4
WORK1() {
    echo "################ PV 생성 #################"
# 1. PV
#(1) View 
fdisk -l | grep LVM | awk '{print $1}' > $TMP1
pvs | tail -n +2 | awk '{print $1}' > $TMP2

cat << EOF
########## PV VIEW ##########
$(cat $TMP1 $TMP2 | sort | uniq -u)
#############################
EOF
#(2) Wroks
echo -n "=> 위의 목록에서 PV로 생성하고 싶은 볼륨을 선택 :"
echo -n "볼륨 선택? (ex: /dev/sdb1 /dev/sdc1 ...): "
read VOLUME

pvcreate $VOLUME >/dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "[ OK ] Physical volume "$VOLUME" successfully created."
    pvs
else
    echo "[ FAIL ] Physical volume not created."
    exit 1
fi
break
}
while true
do
cat << EOF
다음 명령어를 실행 하겠습니까? 
# pvcreate $VOLUME
* yes: 실행, no: 처음부터 다시, skip: 작업 뛰어넘기
EOF
echo -n "선택하세요 (yes|no|skip) : "
read CHICE
case $CHICE in
    yes) WORK1 ;;
    no)  continue;;
    skip) break;;
    *)   continue;;
esac
done

echo "################ VG 생성 #################"
# 2. VG
#(1) View 
vgs | tail -n +2 | awk '{print $1}' > $TMP3
pvs > $TMP4
for i in $(cat $TMP3)
do
    sed -i "/$i/d" $TMP4
done

cat << EOF
########## PV List #########################
$(cat $TMP4)
############################################
EOF
#(2) Wroks
# vgcreate vg1 /dev/sd1 /dev/sdc1
echo -n "VG 이름은? (ex: vg1) : "
read VGNAME

echo -n "선택가능한 PV 목록을 적어 주세요 (ex: /dev/sdb1 /dev/sdc1 ...):"
read PVLIST

vgcreate $VGNAME $PVLIST >/dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "[ OK ] Volume group $VGNAME successfully created"
    
    vgs
else
    echo "[ FAIL ] Volume group not ctreated"
    exit 2
fi
echo "################ LV 생성 #################"
# 3. LV
#(1) View 
cat << EOF
########## PV List #########################
$(vgs | awk '$7 != '0' {print $0}')
############################################
EOF
#(2) Wroks
# lvcreate vg1 -n lv1 -L 500m
echo -n "VG를 생성할 VG 이름은? (ex: vg1) :"
read VGLV

echo -n "생성할 VG 이름은? (ex: lv1) :"
read LVNAME

echo -n "LV 용량은? (ex: 500m) :"
read LVSIZE

lvcreate $VGLV -n $LVNAME -L $LVSIZE >/dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "[ OK ] Logical Volume $LVNAME successfully created."
  
    lvs
else
    echo "[ FAIL ] ogical Volume not created."
    exit 3
fi

