#!/usr/bin/env bash
# macOS 디스크 캐시 정리 스크립트
# Usage: bash cleanup-disk.sh

set -euo pipefail

echo "=== 디스크 사용량 (APFS) ==="
diskutil apfs list | grep -E "Capacity (In Use|Not Allocated)" || df -h /
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

echo "=== npm 캐시 정리 ==="
if command -v npm &>/dev/null; then
  npm cache clean --force 2>&1 | tail -1
else
  echo "npm 없음, 스킵"
fi
echo ""

echo "=== Gradle 캐시 정리 ==="
if [ -d ~/.gradle/caches ]; then
  du -sh ~/.gradle/caches | awk '{print $1, "삭제"}'
  rm -rf ~/.gradle/caches
else
  echo "캐시 없음"
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

echo "=== JetBrains 로그 정리 ==="
if [ -d ~/Library/Logs/JetBrains ]; then
  du -sh ~/Library/Logs/JetBrains | awk '{print $1, "삭제"}'
  rm -rf ~/Library/Logs/JetBrains
else
  echo "로그 없음"
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

echo "=== Outlook 임시 파일 정리 ==="
OUTLOOK_TMP=~/Library/Containers/com.microsoft.Outlook/Data/tmp
if [ -d "$OUTLOOK_TMP" ]; then
  du -sh "$OUTLOOK_TMP" | awk '{print $1, "삭제"}'
  rm -rf "$OUTLOOK_TMP"
else
  echo "임시 파일 없음"
fi
echo ""

echo "=== Claude VM 번들 정리 ==="
CLAUDE_VM="$HOME/Library/Application Support/Claude/vm_bundles"
if [ -d "$CLAUDE_VM" ]; then
  du -sh "$CLAUDE_VM" | awk '{print $1, "삭제"}'
  rm -rf "$CLAUDE_VM"
else
  echo "번들 없음"
fi
echo ""

echo "=== 정리 완료 ==="
diskutil apfs list | grep "Capacity Not Allocated" || df -h /
