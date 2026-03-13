#!/usr/bin/env bash
# 머지 완료된 로컬 브랜치를 정리합니다.
# Usage: bash cleanup-branches.sh [main|master]

set -euo pipefail

BASE_BRANCH="${1:-main}"

echo "Base branch: $BASE_BRANCH"
echo "---"

merged=$(git branch --merged "$BASE_BRANCH" | grep -vE "^\*|main|master|develop" || true)

if [[ -z "$merged" ]]; then
    echo "정리할 브랜치가 없습니다."
    exit 0
fi

echo "삭제 대상:"
echo "$merged"
echo "---"
read -rp "삭제하시겠습니까? (y/N) " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    echo "$merged" | xargs git branch -d
    echo "완료!"
else
    echo "취소됨."
fi
