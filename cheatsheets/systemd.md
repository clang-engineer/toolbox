# systemd & journalctl Cheatsheet

## 서비스 파일 위치

| 유형 | 경로 | 우선순위 | 용도 |
|------|------|----------|------|
| 시스템 (벤더) | `/usr/lib/systemd/system/` | 낮음 | 패키지 제공 서비스 |
| 시스템 (관리자) | `/etc/systemd/system/` | 높음 | 관리자가 정의/오버라이드 |
| 사용자 (전역) | `/etc/systemd/user/` | 중간 | 모든 사용자 대상 |
| 사용자 (개인) | `~/.config/systemd/user/` | 높음 | 해당 사용자만 |

## 서비스 파일 구조

```ini
[Unit]
Description=Service Description
After=network.target

[Service]
ExecStart=/home/{username}/{path_to_script}
User={username}
Group={groupname}

[Install]
WantedBy=multi-user.target
```

## systemctl 명령어

| 명령어 | 설명 |
|--------|------|
| `systemctl start <service>` | 서비스 시작 |
| `systemctl stop <service>` | 서비스 종료 |
| `systemctl restart <service>` | 서비스 재시작 |
| `systemctl status <service>` | 서비스 상태 확인 |
| `systemctl enable <service>` | 부팅 시 자동 시작 |
| `systemctl disable <service>` | 자동 시작 해제 |
| `systemctl daemon-reload` | 서비스 파일 변경 시 데몬 리로드 |
| `systemctl is-enabled <service>` | 자동 시작 여부 확인 |
| `systemctl reset-failed` | 실패한 서비스 상태 초기화 |

> 사용자 서비스: `systemctl --user start myapp.service`

## 서비스 삭제

```bash
systemctl stop <service>
systemctl disable <service>
rm /etc/systemd/system/<service>
systemctl daemon-reload
systemctl reset-failed
```

## 사용자 서비스 유지 (로그아웃 후에도)

```bash
loginctl enable-linger {username}
```

---

## journalctl

systemd 로그 조회 도구.

### 기본 조회

```bash
journalctl                       # 전체 로그
journalctl -n 20                 # 최근 20개
journalctl -x -e                 # 마지막 로그부터 상세히
journalctl --no-pager            # 페이저 없이 출력
```

### 실시간 로그

```bash
journalctl -f                    # tail -f 처럼
journalctl -f -u <service>       # 특정 서비스
```

### 필터링

```bash
# 특정 서비스
journalctl -u <service>

# 특정 PID
journalctl -n _PID=872

# 로그 우선순위 (emerg, alert, crit, err, warning, notice, info, debug)
journalctl -p err

# 날짜/시간
journalctl --since "2024-01-09"
journalctl --since "2024-01-09" --until "2024-01-11"
journalctl --since yesterday
journalctl --since "-2hour"
```

### 조합 예시

```bash
# 특정 서비스 + 최근 50개 + 오류만
journalctl -u my-service -n 50 -p err
```
