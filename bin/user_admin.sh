#!/bin/bash

PASSWD=/etc/passwd

Menu() {
cat << EOF
(관리 목록)
------------------------------------
1) 사용자 추가
2) 사용자 확인
3) 사용자 삭제
4) 종료
------------------------------------
EOF
}

UserAdd() {
    echo "추가할 사용자 이름 :"
    read name1
    cat /etc/passwd | awk -F: '{print $1}' | grep -w $name1 >/dev/null 2>&1
        if [ $? -eq 0 ] ; then
                echo "---------------------------------"
                echo "사용자가 존재합니다."
                echo "---------------------------------"
        else
                useradd $name1
                echo $name1 | passwd --stdin $name1 
                echo "---------------------------------"
                echo "사용자가 추가되었습니다."
                echo "---------------------------------"
        fi
}

UserVerify() {
cat << EOF
(사용자 확인)    
------------------------------------
$(awk -F: '$3 >= 1000 && $3 <= 60000 {print $1}' $PASSWD | cat -n)
------------------------------------

EOF
}

UserDel() {
    echo "(사용자 삭제)"
    echo "삭제할 사용자 이름? : "
    read name
    if [ "$name" = "$name" ]; then
        userdel -r $name

        echo "정상적으로 삭제 되었습니다. "
    else
        echo "잘못 입력"
    fi
    
}

while true
do
    Menu
    echo -n "선택 번호? (1|2|3|4) : "
    read NUM

    case $NUM in
        1) UserAdd ;;
        2) UserVerify ;;
        3) UserDel ;;
        4) break ;;
        *) echo "[ WARN] 잘못된 선택을 했습니다." ; echo
    esac
done