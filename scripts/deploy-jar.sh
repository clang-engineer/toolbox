#!/usr/bin/env bash
# SCP로 JAR 파일을 원격 서버에 배포합니다.
# Usage: bash deploy-jar.sh [옵션]

set -euo pipefail

HOST=""
PORT="22"
USER=""
JAR_PATH=""
REMOTE_PATH=""

usage() {
    cat <<EOF
Usage: $(basename "$0") [옵션]

SCP로 JAR 파일을 원격 서버에 배포합니다.

옵션:
  -h, --host HOST          원격 호스트 (필수)
  -p, --port PORT          SSH 포트 (기본: 22)
  -u, --user USER          SSH 사용자 (필수)
  -j, --jar PATH           JAR 파일 경로 (필수)
  -r, --remote PATH        원격 디렉토리 경로 (필수)
  --help                   이 도움말 출력
EOF
    exit 0
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--host) HOST="$2"; shift 2 ;;
        -p|--port) PORT="$2"; shift 2 ;;
        -u|--user) USER="$2"; shift 2 ;;
        -j|--jar) JAR_PATH="$2"; shift 2 ;;
        -r|--remote) REMOTE_PATH="$2"; shift 2 ;;
        --help) usage ;;
        *) echo "알 수 없는 옵션: $1"; usage ;;
    esac
done

# 필수 인자 검증
MISSING=()
[[ -z "$HOST" ]] && MISSING+=("--host")
[[ -z "$USER" ]] && MISSING+=("--user")
[[ -z "$JAR_PATH" ]] && MISSING+=("--jar")
[[ -z "$REMOTE_PATH" ]] && MISSING+=("--remote")

if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo "오류: 필수 옵션이 누락되었습니다: ${MISSING[*]}"
    echo ""
    usage
fi

# JAR 파일 존재 확인
if [[ ! -f "$JAR_PATH" ]]; then
    echo "오류: JAR 파일을 찾을 수 없습니다: ${JAR_PATH}"
    exit 1
fi

JAR_SIZE=$(du -h "$JAR_PATH" | cut -f1)

echo "배포 정보:"
echo "  JAR 파일:  ${JAR_PATH} (${JAR_SIZE})"
echo "  대상 서버: ${USER}@${HOST}:${PORT}"
echo "  원격 경로: ${REMOTE_PATH}"
echo "---"

read -rp "배포하시겠습니까? (y/N) " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    echo "전송 중..."
    scp -P "$PORT" "$JAR_PATH" "${USER}@${HOST}:${REMOTE_PATH}"
    echo "완료!"
else
    echo "취소됨."
fi
