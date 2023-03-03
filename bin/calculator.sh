#!/bin/bash

echo -n "Enter A: "
read num1
echo -n "Enter B: "
read num2
cat << EOF
==============================================
 (1). +    (2). -    (3). *    (4). /
==============================================
EOF

echo -n "Enter Your Choice ? (1|2|3|4): "
read OP

case $OP in
    1) echo "$num1 + $num2 = `expr $num1 + $num2`" ;;
    2) echo "$num1 - $num2 = `expr $num1 - $num2`" ;;
    3) echo "$num1 * $num2 = `expr $num1 \* $num2`" ;;
    4) echo "$num1 / $num2 = `expr $num1 / $num2`" ;;
    *) echo "[ FAIL ] 계산할 수 없음 " ;  exit 1 
esac

