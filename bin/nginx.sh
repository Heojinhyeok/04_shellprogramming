#!/bin/bash

# httpd 웹서버 설정
# (ㄱ) 패키지 설치 (yum -y install httpd)
# (ㄴ) 서버 설정 (echo "httpd WebServer" > usr/share/nginx/html/index.html)
# (ㄷ) 서비스 기동 (systemctl enable --now nginx.service)
# (ㄹ) 방화벽 등록
# (ㅁ) SELinux
yum install nginx -y \
    && echo "<h1>nginx WebServer</h1>" > /usr/share/nginx/html/index.html \
    && service nginx restart \
    && echo "[ OK ] Nginx Web Server started."


