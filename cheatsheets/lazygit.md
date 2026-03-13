# LazyGit Cheatsheet

Git TUI 도구. CLI 없이 커밋, 브랜치, 리베이스 등을 단축키로 처리.

> 공식 저장소: https://github.com/jesseduffield/lazygit

## 설치

```sh
brew install lazygit        # macOS / Linux
scoop install lazygit       # Windows
go install github.com/jesseduffield/lazygit@latest
```

## 실행

```sh
lazygit                     # Git 리포지토리 내부에서 실행
```

## 인터페이스 구성

| 영역 | 설명 |
|------|------|
| Status | 리포지토리 상태 요약 |
| Files | 변경된 파일 목록 / 스테이징 |
| Branches | 로컬/리모트 브랜치 |
| Commits | 커밋 로그 / diff |
| Stash | 스태시 목록 |

## 주요 단축키

### 전역

| 키 | 동작 |
|------|------|
| `?` | 도움말 |
| `←` / `→` | 패널 이동 |
| `r` | 새로고침 |
| `q` | 종료 |

### Files 패널

| 키 | 동작 |
|------|------|
| `Space` | 파일 스테이징/언스테이징 |
| `Enter` | 파일 상세 (hunk 단위 스테이징 가능) |
| `c` | 커밋 |
| `d` | 변경 버리기 |
| `=` / `-` | 모든 폴더 열기/닫기 |

### Commits 패널

| 키 | 동작 |
|------|------|
| `Enter` | 커밋 상세 |
| `y` | 커밋 관련 정보 복사 |
| `x` | 이전 커밋으로 리셋 |
| `p` | 체리픽 |

### Branches 패널

| 키 | 동작 |
|------|------|
| `Space` | 브랜치 체크아웃 |
| `n` | 새 브랜치 생성 |
| `d` | 브랜치 삭제 |
| `m` | Merge |
| `r` | Rebase |
| `P` | Push / Pull 메뉴 |

### 부분 스테이징

1. Files 패널에서 파일 선택 → `Enter`
2. `Tab`으로 stage/unstage 섹션 전환
3. `Space`로 개별 hunk 스테이징, `d`로 변경 버리기

### 로그 필터

`Ctrl+S`로 로그 필터 모드 활성화

## 설정 (`~/.config/lazygit/config.yml`)

```yaml
gui:
  showFileTree: true
  expandFocusedSidePanel: true
  nerdFontsVersion: "3"
git:
  paging:
    colorArg: always
    pager: delta --dark --paging=never
```

## 트러블슈팅

| 문제 | 해결 |
|------|------|
| 실행 안 됨 | Git 리포지토리 내부에서 실행 |
| 한글 깨짐 | NerdFont 또는 UTF-8 지원 폰트 사용 |
| diff 색상 이상 | config.yml pager 설정 확인 |
