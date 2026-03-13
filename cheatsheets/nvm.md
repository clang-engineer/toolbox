
nvm을 사용하여 노드 버전을 관리하는 방법에 대해 기록

## nvm 설치
```bash
brew install nvm
```

## nvm 설정
```bash
mkdir ~/.nvm # nvm 디렉토리 생성

# nvm 초기화 스크립트를 ~/.zshrc에 추가
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion" 
```

## nvm 사용법
```bash
nvm ls # 설치된 노드 버전 확인
nvm ls-remote # 설치 가능한 노드 버전 확인
nvm ls-remote --lts # 설치 가능한 LTS 노드 버전 확인

nvm install 18.16.0 # 노드 버전 설치
nvm use 18.16.0 # 노드 버전 사용
nvm alias default 18.16.0 # 기본 노드 버전 설정
nvm uninstall 18.16.0 # 노드 버전 삭제
```
