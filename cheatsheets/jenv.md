# jEnv Cheatsheet

Java 버전 관리 도구 (macOS).

## 설치

```sh
brew install jenv
```

## 셸 설정 (~/.zshrc)

```sh
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
```

## Java 설치 (Homebrew)

```sh
brew install openjdk@17
brew install openjdk@21

# 심볼릭 링크 추가 (macOS 필수)
sudo ln -sfn /opt/homebrew/Cellar/openjdk@17/*/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
sudo ln -sfn /opt/homebrew/Cellar/openjdk@21/*/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-21.jdk

# 심볼릭 링크 확인
/usr/libexec/java_home -V
```

## jEnv에 버전 등록

```sh
jenv add /Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/openjdk-21.jdk/Contents/Home
```

## 명령어

```sh
jenv versions               # 등록된 버전 목록
jenv version                # 현재 사용 중인 버전
jenv global 21              # 전역 버전 설정
jenv local 17               # 현재 디렉터리 버전 설정 (.java-version 생성)
jenv shell 17               # 현재 셸 세션 버전 설정
jenv doctor                 # 설정 진단
jenv enable-plugin export   # JAVA_HOME 자동 설정 플러그인
```
