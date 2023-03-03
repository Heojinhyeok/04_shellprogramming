#!/bin/bash

# httpd 웹서버 설정
# (ㄱ) 패키지 설치 (yum -y install httpd)
# (ㄴ) 서버 설정 (echo "httpd WebServer" > /var/www/html/index.html)
# (ㄷ) 서비스 기동 (systemctl enable --now httpd.service)
# (ㄹ) 방화벽 등록
# (ㅁ) SELinux
yum install httpd -y \
    && echo "<h1>httpd WebServer</h1>" > /var/www/html/index.html \
    && service httpd restart \
    && echo "[ OK ] apache HTTD Web Server started."


