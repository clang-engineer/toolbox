---
layout: til
title: "macOS 디스크 용량 정리 명령어"
date: 2026-04-06
categories: [macos]
tags: [disk, cleanup, cache, brew, docker, yarn, gradle, npm, outlook, claude]
---

macOS 228GB 디스크에서 캐시/임시파일 정리만으로 **35GB 확보** 가능했다.

## 용량 큰 디렉토리 찾기

```sh
du -sh ~/Library/Caches/* 2>/dev/null | sort -rh | head -10
du -sh ~/Library/Containers/* 2>/dev/null | sort -rh | head -10
diskutil apfs list | grep "Capacity"  # APFS 실제 사용량 확인 (df보다 정확)
```

## 안전하게 정리 가능한 항목

```sh
# 패키지 매니저 캐시
brew cleanup --prune=all              # Homebrew (~3.8GB)
yarn cache clean                      # Yarn (~1.4GB)
npm cache clean --force               # npm (~2.2GB)

# IDE / 개발 도구 캐시
rm -rf ~/Library/Caches/JetBrains     # JetBrains (~3.4GB, 재시작 시 재생성)
rm -rf ~/Library/Caches/jdtls         # Java LSP (~1.1GB)
rm -rf ~/Library/Logs/JetBrains       # JetBrains 로그 (~223MB)
rm -rf ~/.gradle/caches               # Gradle (~5GB, 빌드 시 재다운로드)

# 앱 임시 파일
rm -rf ~/Library/Containers/com.microsoft.Outlook/Data/tmp  # Outlook 임시 (~7GB)
rm -rf "/Users/zero/Library/Application Support/Claude/vm_bundles"  # Claude VM 번들 (~9.6GB, 재시작 시 최신만 재다운로드)
```

## 주의사항

- `df -h /`는 APFS에서 System 볼륨만 표시할 수 있음 → `diskutil apfs list`가 정확
- Docker는 데몬 실행 상태에서만 `docker system prune -a` 가능
- Claude vm_bundles 삭제해도 대화 기록에 영향 없음
