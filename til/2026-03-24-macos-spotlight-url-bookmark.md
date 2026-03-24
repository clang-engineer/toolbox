---
layout: til
title: "macOS에서 자주 쓰는 URL을 런처로 빠르게 여는 방법"
date: 2026-03-24
categories: [macos]
tags: [raycast, spotlight, macos, productivity]
---

자주 쓰는 URL(SharePoint, OneNote 등)을 `⌘ Space`에서 이름으로 검색해 바로 열고 싶었다.

## 결론: Raycast Quicklink

```bash
brew install --cask raycast
```

`⌥ Space`(기본) → "Create Quicklink" → Name과 URL 입력하면 끝. 이후 이름만 치면 바로 열린다.

Spotlight을 완전히 대체하려면 Raycast 설정(`⌘ ,`) → General에서 Hotkey를 `⌘ Space`로 변경하고, 시스템 설정 → 키보드 단축키 → Spotlight에서 기존 단축키를 해제하면 된다.

## Spotlight으로 시도했던 방법들 (불안정)

| 방법 | 결과 |
|------|------|
| `.webloc` 파일 (XML plist) | `mdfind`에는 잡히지만 Spotlight UI에 안 나옴 |
| `.webloc` 바이너리 plist 변환 | 되다 안 되다 불안정 |
| `.webloc` 심링크 | Spotlight이 인덱싱 안 함 |
| `.app` 번들로 셸 스크립트 포장 | **동작함**, 하지만 해킹에 가까움 |

`.app` 방식은 확실하지만 관리가 번거롭고, Raycast Quicklink가 모든 면에서 나은 대안이었다.
