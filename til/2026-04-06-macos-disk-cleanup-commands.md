---
layout: til
title: "macOS 디스크 용량 정리 명령어"
date: 2026-04-06
categories: [macos]
tags: [disk, cleanup, cache, brew, docker, yarn]
---

macOS에서 캐시만 정리해도 10GB 이상 확보할 수 있다.

## 용량 큰 디렉토리 찾기

```sh
# 홈 디렉토리 하위 용량 확인
du -sh ~/Library/Caches/* 2>/dev/null | sort -rh | head -10
du -sh ~/Library/Containers/* 2>/dev/null | sort -rh | head -10
```

주요 용량 차지 경로:
- `~/Library/Caches/` — Homebrew, JetBrains, Yarn, Chrome 등
- `~/Library/Containers/` — Docker, Outlook, Teams 등
- `~/Library/Application Support/` — Claude, Slack 등

## 안전하게 정리 가능한 캐시

```sh
brew cleanup --prune=all          # Homebrew 다운로드 캐시 + 구버전
yarn cache clean                  # Yarn 패키지 캐시
rm -rf ~/Library/Caches/JetBrains # IDE 재시작 시 재생성됨
rm -rf ~/Library/Caches/jdtls     # Java LSP 캐시
docker system prune -a            # 미사용 이미지/컨테이너 전부 (Docker 실행 필요)
```

위 명령어로 약 **10~20GB** 확보 가능. 캐시는 필요 시 자동 재생성되므로 안전하다.
