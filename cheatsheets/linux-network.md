# Linux Network Cheatsheet

## 네트워크 연결 확인

| 명령어 | 설명 |
|---|---|
| `ping <주소>` | 대상 호스트 응답 확인 |
| `traceroute <주소>` | 목적지까지 경로 확인 |
| `mtr <주소>` | ping + traceroute 결합, 실시간 패킷 손실 확인 |
| `dig <도메인>` | DNS 조회 (nslookup 대체) |
| `nslookup <도메인>` | DNS 조회 (구식) |
| `whois <도메인>` | 도메인 등록 정보 조회 |
| `curl -I <URL>` | 웹 서버 응답 헤더 확인 |
| `nc -zv <IP> <포트>` | 포트 열림 확인 |
| `telnet <IP> <포트>` | 포트 접속 시도 |

## 네트워크 상태 확인

| 명령어 | 설명 |
|---|---|
| `ip a` / `ip addr` | 네트워크 인터페이스 및 IP 확인 |
| `ip r` / `ip route` | 라우팅 테이블 확인 |
| `ss -tulnp` | 열려 있는 포트 및 프로세스 확인 |
| `arp -a` | ARP 테이블 확인 |
| `hostname -I` | 현재 호스트 IP 확인 |

## curl vs wget

| 특징 | curl | wget |
|---|---|---|
| 기본 목적 | 데이터 전송 (요청/응답) | 파일 다운로드 |
| 프로토콜 | HTTP, HTTPS, FTP, SCP, SFTP 등 | HTTP, HTTPS, FTP |
| 재시도 | `--retry` 옵션 필요 | 기본 자동 재시도 |
| 이어받기 | `-C -` 옵션 | 기본 지원 |
| POST 요청 | `-X POST -d "data"` | 제한적 |
| 백그라운드 | 직접 설정 | `-b` 옵션 |
