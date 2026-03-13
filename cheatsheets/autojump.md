# Autojump Cheatsheet

> **Note**: autojump은 더 이상 유지보수되지 않음 (archived). 모던 대안으로 [zoxide](https://github.com/ajeetdsouza/zoxide) 권장.

## 설치

```sh
brew install autojump       # macOS
sudo apt install autojump   # Debian/Ubuntu
```

## 셸 설정

```sh
# Zsh: ~/.zshrc에 플러그인 추가
plugins=(git autojump)

# Bash: ~/.bashrc에 추가
echo '. /usr/share/autojump/autojump.sh' >> ~/.bashrc
```

## 사용법

```sh
j foo       # foo를 포함하는 디렉터리로 이동
jc foo      # 현재 디렉터리 하위에서 foo 검색
jo foo      # foo 디렉터리를 파일 탐색기로 열기
j -s        # 가중치 확인
j --purge   # 존재하지 않는 경로 삭제
```

### 다중 키워드

```sh
# 가중치:
# 30  /home/user/mail/inbox
# 10  /home/user/work/index
j w in      # → /home/user/work/index
```

---

## zoxide (권장 대안)

```sh
# 설치
brew install zoxide         # macOS
sudo apt install zoxide     # Ubuntu 24.04+
cargo install zoxide        # Rust

# 셸 설정 (~/.zshrc)
eval "$(zoxide init zsh)"

# 사용법
z foo       # foo를 포함하는 디렉터리로 이동
zi foo      # fzf로 대화형 선택
```
