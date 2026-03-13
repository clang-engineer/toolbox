# NVM Cheatsheet

Node.js 버전 관리 도구.

## 설치

```sh
brew install nvm            # macOS
```

## 셸 설정 (~/.zshrc)

```sh
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"
```

## 사용법

```sh
nvm ls                      # 설치된 버전 목록
nvm ls-remote --lts         # 설치 가능한 LTS 버전
nvm install --lts           # 최신 LTS 설치
nvm install 20              # 특정 메이저 버전 설치
nvm use 20                  # 버전 전환
nvm alias default 20        # 기본 버전 설정
nvm uninstall 18            # 버전 삭제
nvm current                 # 현재 사용 중인 버전
```

## .nvmrc

프로젝트 루트에 `.nvmrc` 파일로 버전 고정:

```sh
echo "20" > .nvmrc
nvm use                     # .nvmrc에 지정된 버전 사용
```

> **팁**: Oh My Zsh의 `nvm` 플러그인을 사용하면 디렉터리 진입 시 자동으로 `nvm use` 실행.
