
## 설정 파일 위치
- /etc/nginx/nginx.conf

## log 파일 위치
- /var/log/nginx/access.log

## 서비스 관리
- systemctl start nginx : Nginx 서비스 시작
- systemctl stop nginx : Nginx 서비스 중지
- systemctl restart nginx : Nginx 서비스 재시작
- systemctl reload nginx : Nginx 서비스 설정 파일 재로드   // nginx -s reload 와 동일
- systemctl status nginx : Nginx 서비스 상태 확인
- systemctl enable nginx : 부팅시 자동 시작 설정
- systemctl disable nginx : 부팅시 자동 시작 해제

## Nginx 강제 종료
- pkill -9 nginx

## 설정 파일 문법 검사
- nginx 설정이 잘 되어 있는지 확인: nginx -t
