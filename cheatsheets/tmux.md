# Tmux Cheatsheet

> prefix = `Ctrl+b` (기본값)

## 세션

```bash
tmux new -s <name>           # 생성
tmux ls                      # 목록
tmux attach -t <name>        # 접속
tmux kill-session -t <name>  # 삭제
```

| 키 | 동작 |
|---|---|
| `prefix d` | detach (나가기) |
| `prefix s` | 세션 목록 |
| `prefix $` | 세션 이름 변경 |

## 윈도우

| 키 | 동작 |
|---|---|
| `prefix c` | 새 윈도우 |
| `prefix ,` | 이름 변경 |
| `prefix n` / `p` | 다음 / 이전 |
| `prefix <번호>` | 번호로 이동 |
| `prefix &` | 윈도우 닫기 |
| `prefix w` | 윈도우 목록 |

## 패인

| 키 | 동작 |
|---|---|
| `prefix %` | 세로 분할 |
| `prefix "` | 가로 분할 |
| `prefix 방향키` | 패인 이동 |
| `prefix z` | 패인 줌 토글 |
| `prefix x` | 패인 닫기 |
| `prefix {` / `}` | 패인 위치 교환 |
| `prefix space` | 레이아웃 변경 |

## 복사 모드

| 키 | 동작 |
|---|---|
| `prefix [` | 복사 모드 진입 |
| `q` | 복사 모드 나가기 |
| `space` → `enter` | 선택 시작 → 복사 |
| `prefix ]` | 붙여넣기 |
