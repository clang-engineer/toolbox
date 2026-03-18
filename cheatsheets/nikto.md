# Nikto Cheatsheet

오픈소스 웹 서버 취약점 스캐너. 위험한 파일, 잘못된 설정, 오래된 소프트웨어 등을 탐지한다.

## 기본 사용법

```bash
# 기본 스캔
nikto -h http://example.com

# 결과를 파일로 저장
nikto -h http://example.com -o result.txt

# 스캔 완료 후 macOS 알림
nikto -h http://example.com -o result.txt && osascript -e 'display notification "Nikto Scan Completed" with title "Nikto"'

# 포트 지정
nikto -h http://example.com -p 8080

# 여러 포트 스캔
nikto -h http://example.com -p 80,443,8080

# IP 대역 스캔 (호스트 파일)
nikto -h hosts.txt
```

## 주요 옵션

| 옵션 | 설명 |
|------|------|
| `-h <host>` | 대상 호스트 (URL, IP, 파일) |
| `-p <port>` | 대상 포트 (기본: 80) |
| `-o <file>` | 결과 출력 파일 |
| `-Format <fmt>` | 출력 형식 (csv, htm, json, nbe, sql, txt, xml) |
| `-ssl` | SSL/TLS 강제 사용 |
| `-nossl` | SSL 사용 안 함 |
| `-timeout <sec>` | 요청 타임아웃 (기본: 10초) |
| `-Pause <sec>` | 요청 간 대기 시간 |
| `-maxtime <sec>` | 최대 스캔 시간 |
| `-until <condition>` | 종료 조건 (예: `nikto -until 200`) |
| `-no404` | 404 추측 비활성화 |
| `-Display <opt>` | 출력 제어 (아래 참고) |
| `-evasion <tech>` | IDS 회피 기법 |
| `-Plugins <list>` | 사용할 플러그인 지정 |
| `-update` | 플러그인/DB 업데이트 |
| `-Version` | 버전 확인 |
| `-list-plugins` | 사용 가능한 플러그인 목록 |

## 출력 형식 (-Format)

```bash
# HTML 리포트
nikto -h http://example.com -o report.html -Format htm

# JSON 출력
nikto -h http://example.com -o report.json -Format json

# XML 출력
nikto -h http://example.com -o report.xml -Format xml

# CSV 출력
nikto -h http://example.com -o report.csv -Format csv
```

## 튜닝 (-Tuning)

특정 유형의 테스트만 실행하거나 제외할 수 있다.

| 번호 | 테스트 유형 |
|------|------------|
| `0` | 파일 업로드 |
| `1` | 흥미로운 파일/로그 |
| `2` | 잘못된 설정/기본 파일 |
| `3` | 정보 노출 |
| `4` | XSS/Script Injection |
| `5` | 원격 파일 검색 (웹 루트 내) |
| `6` | DoS (서비스 거부) |
| `7` | 원격 파일 검색 (서버 전체) |
| `8` | 명령어 실행/원격 쉘 |
| `9` | SQL Injection |
| `a` | 인증 우회 |
| `b` | 소프트웨어 식별 |
| `c` | 원격 소스 포함 |
| `x` | 역방향 튜닝 (지정한 것 제외) |

```bash
# XSS + SQL Injection만 테스트
nikto -h http://example.com -Tuning 49

# 정보 노출 제외하고 스캔
nikto -h http://example.com -Tuning x3
```

## Display 옵션

| 값 | 설명 |
|----|------|
| `1` | 리다이렉트 표시 |
| `2` | 쿠키 표시 |
| `3` | 200/OK 응답 표시 |
| `4` | 인증이 필요한 URL 표시 |
| `D` | 디버그 출력 |
| `V` | 상세(Verbose) 출력 |

```bash
nikto -h http://example.com -Display V
```

## SSL/TLS 스캔

```bash
# HTTPS 사이트 스캔
nikto -h https://example.com

# SSL 강제
nikto -h example.com -p 443 -ssl

# 특정 SSL 포트
nikto -h example.com -p 8443 -ssl
```

## 프록시 설정

```bash
# HTTP 프록시 경유
nikto -h http://example.com -useproxy http://proxy:8080

# Burp Suite 연동
nikto -h http://example.com -useproxy http://127.0.0.1:8080
```

## 인증

```bash
# Basic 인증
nikto -h http://example.com -id admin:password

# NTLM 인증 (도메인 포함)
nikto -h http://example.com -id admin:password:domain
```

## IDS 회피 (-evasion)

| 번호 | 기법 |
|------|------|
| `1` | 랜덤 URI 인코딩 |
| `2` | 자기 참조 디렉토리 (/./) |
| `3` | 조기 URL 종료 |
| `4` | 긴 랜덤 문자열 추가 |
| `5` | 가짜 파라미터 |
| `6` | TAB을 공백 대신 사용 |
| `7` | URL 대소문자 변환 |
| `8` | 디렉토리 구분자(\) 사용 |

```bash
nikto -h http://example.com -evasion 1234
```

## 플러그인

```bash
# 사용 가능한 플러그인 목록
nikto -list-plugins

# 특정 플러그인만 실행
nikto -h http://example.com -Plugins "apache_expect_xss;outdated"

# 모든 플러그인 실행
nikto -h http://example.com -Plugins "@@ALL"

# 기본 플러그인만
nikto -h http://example.com -Plugins "@@DEFAULT"
```

## 실전 예제

```bash
# 종합 스캔 (SSL + 상세 출력 + HTML 리포트)
nikto -h https://target.com -ssl -Display V -o report.html -Format htm

# 빠른 스캔 (정보 노출 + 잘못된 설정만)
nikto -h http://target.com -Tuning 23

# Burp 프록시 경유 + 인증 + 타임아웃
nikto -h http://target.com -id admin:pass -useproxy http://127.0.0.1:8080 -timeout 15

# 여러 호스트 일괄 스캔
echo -e "192.168.1.1\n192.168.1.2\n192.168.1.3" > targets.txt
nikto -h targets.txt -o results.txt

# 최대 10분간 스캔
nikto -h http://target.com -maxtime 600

# nmap과 연동 (웹 서버 포트 자동 탐지 후 스캔)
nmap -p 80,443,8080 -oG - target.com | nikto -h -
```

## 설치

```bash
# macOS (Homebrew)
brew install nikto

# Debian/Ubuntu
sudo apt install nikto

# 소스에서 설치
git clone https://github.com/sullo/nikto.git
cd nikto
perl program/nikto.pl -h http://example.com

# DB/플러그인 업데이트
nikto -update
```
