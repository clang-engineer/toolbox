#!/usr/bin/env bash
# 특정 포트를 사용 중인 프로세스를 찾고, 선택적으로 종료합니다.
# Usage: bash port-check.sh <port>

set -euo pipefail

PORT="${1:?포트 번호를 입력하세요. (예: bash port-check.sh 8080)}"

echo "포트 $PORT 사용 중인 프로세스:"
echo "---"

if command -v lsof &>/dev/null; then
    result=$(lsof -i :"$PORT" 2>/dev/null || true)
elif command -v ss &>/dev/null; then
    result=$(ss -tlnp "sport = :$PORT" 2>/dev/null || true)
elif command -v netstat &>/dev/null; then
    result=$(netstat -ano | grep ":$PORT " || true)
else
    echo "lsof, ss, netstat 모두 없습니다."
    exit 1
fi

if [[ -z "$result" ]]; then
    echo "포트 $PORT을 사용 중인 프로세스가 없습니다."
    exit 0
fi

echo "$result"
