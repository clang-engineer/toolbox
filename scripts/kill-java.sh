#!/usr/bin/env bash
# Java 프로세스를 확인 후 종료합니다.
# Usage: bash kill-java.sh [옵션]

set -euo pipefail

FORCE=false
DRY_RUN=false

usage() {
    cat <<EOF
Usage: $(basename "$0") [옵션]

실행 중인 Java 프로세스를 확인 후 종료합니다.

옵션:
  --force      SIGKILL(9)로 강제 종료
  --dry-run    실제 종료 없이 프로세스 목록만 출력
  --help       이 도움말 출력
EOF
    exit 0
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --force) FORCE=true; shift ;;
        --dry-run) DRY_RUN=true; shift ;;
        --help) usage ;;
        *) echo "알 수 없는 옵션: $1"; usage ;;
    esac
done

# Java 프로세스 검색
PIDS=$(pgrep java || true)

if [[ -z "$PIDS" ]]; then
    echo "실행 중인 Java 프로세스가 없습니다."
    exit 0
fi

echo "실행 중인 Java 프로세스:"
echo "---"
# shellcheck disable=SC2009
ps -p "$PIDS" -o pid,user,start,command 2>/dev/null || ps aux | grep '[j]ava'
echo "---"

if [[ "$DRY_RUN" == true ]]; then
    echo "[dry-run] 종료하지 않았습니다."
    exit 0
fi

SIGNAL="SIGTERM"
if [[ "$FORCE" == true ]]; then
    SIGNAL="SIGKILL"
fi

read -rp "${SIGNAL}로 종료하시겠습니까? (y/N) " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    if [[ "$FORCE" == true ]]; then
        echo "$PIDS" | xargs kill -9
    else
        echo "$PIDS" | xargs kill
    fi
    echo "완료! (${SIGNAL})"
else
    echo "취소됨."
fi
