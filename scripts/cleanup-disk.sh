#!/usr/bin/env bash
# macOS 디스크 캐시 정리 스크립트
# Usage: bash cleanup-disk.sh

set -euo pipefail

echo "=== 디스크 사용량 ==="
df -h / | awk 'NR==2{printf "전체: %s / 사용: %s / 남은: %s\n", $2, $3, $4}'
echo ""

echo "=== Homebrew 캐시 정리 ==="
brew cleanup --prune=all 2>&1 | tail -1
echo ""

echo "=== Yarn 캐시 정리 ==="
if command -v yarn &>/dev/null; then
  yarn cache clean 2>&1 | tail -1
else
  echo "yarn 없음, 스킵"
fi
echo ""

echo "=== JetBrains 캐시 정리 ==="
if [ -d ~/Library/Caches/JetBrains ]; then
  du -sh ~/Library/Caches/JetBrains | awk '{print $1, "삭제"}'
  rm -rf ~/Library/Caches/JetBrains
else
  echo "캐시 없음"
fi
echo ""

echo "=== jdtls 캐시 정리 ==="
if [ -d ~/Library/Caches/jdtls ]; then
  du -sh ~/Library/Caches/jdtls | awk '{print $1, "삭제"}'
  rm -rf ~/Library/Caches/jdtls
else
  echo "캐시 없음"
fi
echo ""

echo "=== npm 캐시 정리 ==="
if command -v npm &>/dev/null; then
  npm cache clean --force 2>&1 | tail -1
else
  echo "npm 없음, 스킵"
fi
echo ""

echo "=== 정리 완료 ==="
df -h / | awk 'NR==2{printf "남은 공간: %s\n", $4}'
