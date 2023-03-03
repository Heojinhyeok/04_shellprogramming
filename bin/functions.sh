# Variable Definitions
export PKG_DOWN_DIR=/root/bin
export VSFTPD_FTPUSERS=/etc/vsftpd/ftpusers
export VSFTPD_USERLIST=/etc/vsftpd/user_list
export SSHD_CONF=/etc/ssh/sshd_config

# Function Definitions
function print_good () {
    echo -e "\x1B[01;32m[+]\x1B[0m $1"
}

function print_error () {
    echo -e "\x1B[01;31m[-]\x1B[0m $1"
}

function print_info () {
    echo -e "\x1B[01;34m[*]\x1B[0m $1"
}

PkgInst() {
    # input: pkgs
    # output: output string
    # finctions:
    PKGS=$*
    # echo $PKGS
    yum -qy install $PKGS >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[ OK ] $PKGS 설치가 완료 되었음"
    else 
        echo "[ FAIL ] 설치가 되지 않았음"
        exit 1
    fi
}
SvcEnable() {
    SVC="$1"
    systemctl enable --now $SVC >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[ OK ] $SVC 유닛이 기동 되었음"
    else
        echo "[ FAIL ] $SVC 유닛이 기동되지 않았음"
    
    fi
}

VScodeInst() {
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    cat << EOF > /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" 
EOF
    PkgInst "code"
}

VScodeComment() {
    cat << EOF
    * 실행은 다음과 같이 합니다.
    (root 사용자) # vscode --no-sandbox  --user-data-dir=$HOME/workspace
    (일반 사용자) # code
    * 관리자인 경우 alias 설정해서 사용하시면 편합니다.
    * 관리자로 vscode를 실행하는 것을 권장하지 않는다.

EOF
}

chromeInst() {
    URL="https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"
    CHROME_PKG=$(basename $URL)

    wget $URL -O $PKG_DOWN_DIR/$CHROME_PKG >/dev/null 2>&1
    if [ $? -eq 0 ] ; then
        echo "[ OK ] Chrome 다운로드가 완료되었음"
    else
        echo "[ FAIL ] Chrome 다운로드가 완료되지 않았음"
        exit 1
    fi
   
    yum -qy localinstall $PKG_DOWN_DIR/$CHROME_PKG >/dev/null 2>&1

    if [ $? -eq 0 ] ; then
        echo "[ OK ] Chrome 패키지 설치가 완료 되었음"
    else
        echo "[ FAIL ] Chrome 패키지 설치가 설치되지 않음 "
    fi
}

VsFtpConf() {
    sed -i 's/^root/#root/' $VSFTPD_FTPUSERS
    sed -i 's/^root/#root/' $VSFTPD_USERLIST
    echo "[ OK ] FTP 설정이 완료 되었음"
}

SshConf() {
    sed -i 's/PermitRootLogin no/PermitRootLogin yes/' $SSHD_CONF
    sed -i 's/#PermitRootLogin/PermitRootLogin/' $SSHD_CONF
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' $SSHD_CONF
    sed -i 's/#PasswordAuthentication/PasswordAuthentication/' $SSHD_CONF
    echo "[ OK ] SSH 설정이 완료 되었음"
}

CheckWebSvc() {
    # input: str(nginx|httpd)
    # output:str(httpd|nginx)
    # function:

    WEBSVC=$1 # Web serivce 변수
    case $WEBSVC in
        nginx) CHECKWEBSVC=httpd ;;
        httpd) CHECKWEBSVC=nginx ;;
        
    esac
    systemctl disable --now $CHECKWEBSVC >/dev/null 2>&1
}

NginxConf() {
    echo "NGINX WebServer" > /usr/share/nginx/html/index.html
    echo "[ OK ] WEB 설정이 완료 됨"
}

