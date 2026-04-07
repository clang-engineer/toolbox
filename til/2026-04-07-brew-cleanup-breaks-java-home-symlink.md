---
layout: til
title: "brew cleanup 후 java_home 심볼릭 링크 깨지는 문제"
date: 2026-04-07
categories: [java, macos]
tags: [brew, jenv, jdtls, symlink, java_home]
---

`brew cleanup`으로 이전 버전 JDK가 삭제되면 `/Library/Java/JavaVirtualMachines/` 심볼릭 링크가 깨져서 `java_home`과 jdtls가 해당 버전을 찾지 못한다.

## 증상

```sh
/usr/libexec/java_home -v 21
# → 엉뚱하게 17을 반환하거나 에러

jenv local 21
# → version `21' not installed
```

Neovim jdtls에서 `jdtls requires at least Java 21` 에러 발생.

## 원인

Homebrew가 `openjdk@21`을 21.0.9 → 21.0.10으로 업데이트한 뒤, `brew cleanup`이 이전 버전(21.0.9)을 삭제. 하지만 시스템 심볼릭 링크는 여전히 삭제된 경로를 가리킴:

```sh
ls -la /Library/Java/JavaVirtualMachines/openjdk-21.jdk
# → /opt/homebrew/Cellar/openjdk@21/21.0.9/libexec/openjdk.jdk (존재하지 않음)
```

## 해결

심볼릭 링크를 현재 설치된 버전으로 갱신:

```sh
sudo ln -sfn /opt/homebrew/Cellar/openjdk@21/21.0.10/libexec/openjdk.jdk \
  /Library/Java/JavaVirtualMachines/openjdk-21.jdk
```

## 확인

```sh
/usr/libexec/java_home -V
# → 21.0.10이 목록에 포함되는지 확인
```

## 교훈

- `brew cleanup` 후 Java 관련 문제가 생기면 `/Library/Java/JavaVirtualMachines/` 심볼릭 링크 확인
- `jenv versions`에 보여도 `java_home`에서 못 찾을 수 있음 — 둘은 별개 시스템
