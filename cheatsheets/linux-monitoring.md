# Linux Monitoring Cheatsheet

하드웨어 자원(CPU, 메모리, 디스크, 네트워크) 모니터링 명령어.

## CPU

```sh
mpstat | tail -1 | awk '{print 100-$NF}'           # CPU 사용률 (%)
top -b -n1 | grep -Po '[0-9.]+ id' | awk '{print 100-$1}'  # top에서 CPU 사용률
uptime                                              # 로드 평균
```

## 메모리

```sh
free -h                                             # 메모리 사용량
cat /proc/meminfo | grep Mem                        # 상세 메모리 정보
sar -r 1                                            # 메모리 통계 (sysstat)
```

## 디스크

```sh
df -h                                               # 파일시스템 사용량
du -sh *                                            # 폴더별 용량
du -sh * | sort -hr | head -10                      # 용량 큰 순 정렬
iostat -x 1                                         # 디스크 I/O 통계 (sysstat)
```

## 네트워크

```sh
ss -tuln                                            # 열린 포트 (netstat 대체)
ifstat                                              # 인터페이스 입출력 통계
netstat -i                                          # 인터페이스 통계 (레거시)
lsof -i :<port>                                     # 포트 사용 프로세스
```

## 프로세스

```sh
ps aux                                              # 전체 프로세스
ps aux | grep <name>                                # 특정 프로세스 검색
top                                                 # 실시간 모니터
htop                                                # 향상된 모니터
kill <pid>                                          # 프로세스 종료
kill -9 <pid>                                       # 강제 종료
```

## 종합 모니터링 도구

| 도구 | 설명 |
|------|------|
| `nmon` | CPU/메모리/디스크/네트워크 통합 TUI (`c`, `m`, `d`, `n` 키로 전환) |
| `atop` | 상세 자원 모니터링 + 로그 기록/분석 |
| `htop` | 향상된 프로세스 모니터 |
| `Netdata` | 웹 기반 실시간 대시보드 |

## 로그 파일

| 경로 | 설명 | 확인 명령 |
|------|------|-----------|
| `/var/log/messages` | 시스템 전반 메시지 | `tail -f` |
| `/var/log/secure` | 인증 로그 (ssh, sudo 등) | `tail -f` |
| `/var/log/boot.log` | 부팅 로그 | `cat` |
| `/var/log/cron` | cron 작업 로그 | `tail -f` |
| `/var/log/maillog` | 메일 로그 | `tail -f` |
| `/var/log/wtmp` | 로그인/로그아웃 기록 (바이너리) | `last` |
| `/var/log/btmp` | 로그인 실패 기록 (바이너리) | `lastb` |
| `/var/log/lastlog` | 최종 로그인 기록 (바이너리) | `lastlog` |
| `/var/run/utmp` | 현재 로그인 사용자 (바이너리) | `who` |
