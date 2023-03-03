#!/bin/bash

echo -n "너의 선택은? (yes or no) :"
read CHOICE

case $CHOICE in
    yes|Y|YES|y|Yes) echo "[ OK ] YES 선택 " ;;
    no|N|NO|n|No)  echo "[ FAIL ] NO 선택 " ;;
    *) echo "[ FAIL ] yes 또는 no를 입력하지 않았음 " ;;

esac