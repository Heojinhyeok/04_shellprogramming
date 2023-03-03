베시 쉘 프로그래밍

1. 선수지식
1) 명령어
	grep CMD
		# grep OPTIONS PATTERNS file1
		OPTION: i. -v, -l, n, -r, -w
		PATTERNS: *  .  ^root  root$  [abc] [a-c] [^a] 
	sed CMD
		p# sed -n '1,3p' /etc/hosts
		d# sed '1,3d' /etc/hosts
		s# sed '/main/s/192.168.10.10/192.168.10.20/' /etc/hosts
	awk CMD
		# awk 'statement {action}' file
		# awk -F: '$3 >= 1000 && $3 <= 60000 {print $1}' /etc/passwd 
		# df -h / | tail -1 | awk '{print $6}' | awk -F% '{print $1}'
		# ifconfig eth0 | grep inet | grep -v inet6 | awk '{print $2}' | awk -F: '{print $2}'
		# ps -elf | awk '$2 == "Z" {print $0}'
	+
	CMD(sort CMD, cut CMD, ...)
2) 쉘의 특성 
	Redirection(<, 0<, >, 1>, >>, 1>>, 2>, 2>>)
	Pipe(|)
	Variable
	Metacharacter
	History
	Alias
	Function
		(선언 )fun() {CMD; CMD;}
		(실행) fun
		(확인) typeset -f
		(삭제) unset -f fun
	Environment File(s) (/etc/profile, ~/.bahs_profile, ~/.bashrc)

	* cat CMD + <<
	* Grouping
	* &&, ||
		A && B
		A && B || c
		A || B
	* dirname/basename CMD
	* eval CMD
2. Shell Script/Shell Programming

------------------------------------------------------------------------------
systemctl disabled --now firewalld
방화벽 끄고 SELINUX 끄기
/etc/selinux/config
SELINUX=disabled

# sed -i 's/SELINUX=permissive/SELINUX=disabled/ /etc/selinux/config'
# reboot
-------------------------------------------------------------------------------
PATH=$PATH:$HOME/scripts
1) 프로그램 작성과 실행
	# bash -x script.sh
	# . ~/.bashrc
	# vi script.sh ; chmod +x script.sh ; ./script.sh
	# vi script.sh ; chmod +x script.sh ; ./script.sh
	
	[참고] 매직넘버 (#!/bin/bash)
2) 주석처리
	* 한줄 주석 - #
	* 여러줄 주석 - : << EOF ~ EOF

3) 입력 & 출력
	출력: echo CMD, printf CMD
	입력: read CMD	

4) 산술연산
	expr 1 + 2
	expr 3 - 1
	expr 3 /* 3
	expr 10 / 2
	expr 10 % 3
5) 조건문: if 문, case 문
	* if 문
		 if 조건; then

		elif 조건; then

		else 
		fi
	* case 문
		case VAR in
			조건1) statement1 ; ;
			조건2) statement1 ; ;
			*)       statement1 ; ;
		esac 



IDE(vscode) ? 통합 개발 환경
LINUX) vscode
	# firefox http://www.google.com
 	vscode download 검색 -> linux rpm 설치
	# cd 다운로드
	# ls
	# yum localinstall *.rpm 

	vscode 단축기
	<CTRL + /> 주석표시
WINDOWS) vscode

6) 반복문: for 문, while문
* for 문: for 문 + seq CMD
	* for var in var_list
	do
		statement
	done

 	*while문:
	  while 조건
	do
		statement
	done	


7) 함수 
	선언)
		fun() { CMD; CMD;}
		finction fun {CMD; CMD;}
	실행) fun
	확인) typeset -f
	해제) unset -f fun

	함수입력: 인자($1, $2, $3, ...)
	함수출력: echo $RET
	
8) IO 리다이렉션과 자식 프로세스
	for LINE in $(cat file1)
	do
		echo $LINE
	done > file2
---------------------------------------------- 변수이름이 여러개 일때
	cat file1 | while read LINE
	do
		echo $LINE
	done > file2
----------------------------------------------

9) 시그널 제어(Signal Trap)
	* 시그널 무시
	* 시그널 받으면 개발자가 원하는 동작

10) 디버깅
	* bash -x script.sh
	* bash -xv script.sh

11) 옵션 처리
	getopts CMD + while CMD + case CMD
	# ssh.sh -p 80 192.168.10.20
	while getopts p: options
	do
		case $options in
			p) P_ACTION ;;
			\?) Usage    ;;
			* ) Usage     ;;
		esac
	done

	shift $(expr $OPTIND - 1 )
	if [ $# -ne 1 ] ; then
		Usage
	fi
	echo "$# : $@"


------------------ 02.28
vscode 자동으로 꺼지도록 설정
* crontab + vskill.sh

kill $(ps -ef | grep -w code \
			| grep -v 'grep --color' \
			| awk '{print $2}' \
			| sort -n | head -1)
---------------------
partition
LV(PV -> VG -> LV)
	./lvm.sh
-------------------------	
PV 작업

보기

선택(ex: /dev/sdb1 /dev/sdc1 ...)?
	# pvcreate /dev/sda1 /dev/sdb1 /dev/sdc1
fdisk -l | grep LVM | awk '{print $1}'
pvs | tail -n +2 | awk '{print $1}'
=> 작업 
-------------------------	
VG작업

보기

선택(ex: ...)
=> 작업
-------------------------	
LV 작업

보기

선택(ex: ...)
=> 작업


filesystem
mount



ENV1.sh : 환경설정
	* $HOME/.bashrc
-----------------------------------------------
#
# Sfecific configuration
#
export PS1='\[\e[31;1m\][\u@\h\[\e[33;1m\] \w]\$ \[\e[m\]'
alias lsf='ls -l | grep "^-"'
alias lsd='ls -l | grep "^d"'
alias ls='ls --color=auto -h -F'
alias c='clear'
alias cear='clear'
alias clar='clear'
alias pps='ps -ef | head -1 ; ps -ef | grep $1'
alias nstate='netstat -antup | head -2 ; netstat -antup | grep $1'
alias tree='env LANG=C tree'
alias vi='/usr/bin/vim'
alias grep='grep --color=auto -i'
alias df='df -h -T'
alias chrome='/usr/bin/google-chrome --no-sandbox'
alias RS='rsync -avz --delete -e ssh'
alias LS='rsync -av --delete'
alias fwcmd='firewall-cmd'
alias fwlist='firewall-cmd --list-all'
alias fwreload='firewall-cmd --reload'
-----------------------------------------------
ENV2.sh : 필요한 패키지 설치
	* 패키지 설치(gcc, ,php, vscode, chrome)
ENV3.sh : 서버 세팅
	* telnet (root 사용자 접속 가능)
		# yum install -y telnet telnet-server
		# systemctl enable telnet.socket
		
	* ftp 서버 (root 사용자 접속 가능)
		# yum -y install vsftpd ftp
		# sed -i '/^root/#root/' /etc/vsftpd/ftpusers
		# sed -i '/^root/#root/' /etc/vsftpd/user_list
		# systemctl enable --now vsftpd.service

	* ssh 서버 (root 사용자 접속 가능)
		# yum -y install openssh-server openssh-clients openssh
		# sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
    		# sed -i 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config

   		# sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
   		# sed -i 's/#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config
		# systemctl enable --now sshd.service

	* nginx web 서버 (index.html)
		# yum -y install nginx
		# echo "Nginx WebServer" > /usr/share/nginx/html/index.html
		# systemctl enable --now nginx.service




rpm --import https://packages.microsoft.com/keys/microsoft.asc

sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

yum install code -y

rpm --import https://packages.microsoft.com/keys/microsoft.asc

cat << EOF > /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" 
EOF

yum install code

wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -o
* wget
* curl

