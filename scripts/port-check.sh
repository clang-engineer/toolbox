#!/usr/bin/env bash
# 특정 포트를 사용 중인 프로세스를 찾고, 선택적으로 종료합니다.
# Usage: bash port-check.sh <port> [옵션]

set -euo pipefail

FORCE=false
KILL=false
PORT=""

usage() {
  cat <<EOF
Usage: $(basename "$0") <port> [옵션]

특정 포트를 사용 중인 프로세스를 찾고, 선택적으로 종료합니다.

옵션:
  --kill       프로세스 종료 (확인 후)
  --force      확인 없이 SIGKILL(9)로 강제 종료
  --help       이 도움말 출력

예시:
  $(basename "$0") 8080           # 포트 8080 사용 프로세스 조회
  $(basename "$0") 8080 --kill    # 조회 후 종료 여부 확인
  $(basename "$0") 8080 --force   # 확인 없이 즉시 강제 종료
EOF
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
  --kill)
    KILL=true
    shift
    ;;
  --force)
    FORCE=true
    KILL=true
    shift
    ;;
  --help) usage ;;
  *)
    if [[ -z "$PORT" ]]; then
      PORT="$1"
      shift
    else
      echo "알 수 없는 옵션: $1"
      usage
    fi
    ;;
  esac
done

if [[ -z "$PORT" ]]; then
  echo "포트 번호를 입력하세요. (예: bash port-check.sh 8080)"
  exit 1
fi

# PID 조회
if command -v lsof &>/dev/null; then
  PIDS=$(lsof -t -i :"$PORT" 2>/dev/null || true)
  result=$(lsof -i :"$PORT" 2>/dev/null || true)
elif command -v ss &>/dev/null; then
  result=$(ss -tlnp "sport = :$PORT" 2>/dev/null || true)
  PIDS=$(echo "$result" | grep -oP 'pid=\K[0-9]+' | sort -u || true)
elif command -v netstat &>/dev/null; then
  result=$(netstat -tlnp 2>/dev/null | grep ":$PORT " || true)
  PIDS=$(echo "$result" | grep -oP '[0-9]+(?=/)' | sort -u || true)
else
  echo "lsof, ss, netstat 모두 없습니다."
  exit 1
fi

if [[ -z "$PIDS" ]]; then
  echo "포트 $PORT을 사용 중인 프로세스가 없습니다."
  exit 0
fi

echo "포트 $PORT 사용 중인 프로세스:"
echo "---"
echo "$result"
echo "---"

if [[ "$KILL" != true ]]; then
  exit 0
fi

if [[ "$FORCE" == true ]]; then
  echo "$PIDS" | xargs kill -9
  echo "포트 $PORT 프로세스 강제 종료 완료 (SIGKILL)"
  exit 0
fi

read -rp "종료하시겠습니까? (y/N) " confirm
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
  echo "$PIDS" | xargs kill -9
  echo "포트 $PORT 프로세스 종료 완료"
else
  echo "취소됨."
fi
