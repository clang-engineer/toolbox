# Nginx Cheatsheet

## 파일 위치

| 항목 | 경로 |
|------|------|
| 메인 설정 | `/etc/nginx/nginx.conf` |
| 사이트 설정 | `/etc/nginx/conf.d/` 또는 `/etc/nginx/sites-available/` |
| 액세스 로그 | `/var/log/nginx/access.log` |
| 에러 로그 | `/var/log/nginx/error.log` |

## 서비스 관리

```sh
systemctl start nginx       # 시작
systemctl stop nginx        # 중지
systemctl restart nginx     # 재시작
systemctl reload nginx      # 설정 리로드 (무중단)
systemctl status nginx      # 상태 확인
systemctl enable nginx      # 부팅 시 자동 시작
systemctl disable nginx     # 자동 시작 해제
```

## 설정 관리

```sh
nginx -t                    # 설정 파일 문법 검사
nginx -T                    # 설정 파일 전체 출력 + 문법 검사
nginx -s reload             # 설정 리로드 (systemctl reload와 동일)
nginx -s quit               # 정상 종료 (처리 중인 요청 완료 후)
nginx -s stop               # 즉시 종료
nginx -V                    # 빌드 정보 및 모듈 확인
```

## 기본 설정 예시

```nginx
server {
    listen 80;
    server_name example.com;

    location / {
        root /var/www/html;
        index index.html;
    }

    # 리버스 프록시
    location /api/ {
        proxy_pass http://localhost:3000/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    # 정적 파일 캐싱
    location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }
}
```

## 디버깅

```sh
tail -f /var/log/nginx/error.log      # 에러 로그 실시간 확인
tail -f /var/log/nginx/access.log     # 액세스 로그 실시간 확인
pkill -9 nginx                        # 강제 종료 (최후의 수단)
```
