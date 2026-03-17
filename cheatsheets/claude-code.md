# Claude Code Cheatsheet

## 기본 내장 명령어

| 명령어 | 설명 |
|--------|------|
| `/help` | 도움말 표시 |
| `/clear` | 대화 초기화 |
| `/compact` | 컨텍스트 압축 (토큰 절약) |
| `/config` | 설정 열기/변경 |
| `/cost` | 토큰 사용량/비용 확인 |
| `/doctor` | 설치 상태 진단 |
| `/init` | CLAUDE.md 프로젝트 설정 파일 생성 |
| `/login` | 계정 로그인 |
| `/logout` | 계정 로그아웃 |
| `/mcp` | MCP 서버 상태 확인 |
| `/memory` | 메모리 파일 편집 |
| `/model` | 사용할 모델 변경 |
| `/permissions` | 도구 권한 설정 |
| `/review` | PR 코드 리뷰 |
| `/status` | git 상태 확인 |
| `/terminal-setup` | 터미널 환경 설정 |
| `/vim` | vim 키바인딩 토글 |
| `/fast` | 빠른 출력 모드 토글 (같은 모델) |

## 실행 옵션

| 명령어 | 설명 |
|--------|------|
| `claude` | 대화형 모드 시작 |
| `claude "prompt"` | 원샷 실행 |
| `claude -c` | 마지막 대화 이어서 시작 |
| `claude -r <session>` | 특정 세션 복원 |
| `claude -p "prompt"` | 파이프 모드 (stdin/stdout) |
| `echo "code" \| claude -p "review"` | 파이프 입력 |
| `claude --model <model>` | 모델 지정 실행 |
| `claude config` | CLI에서 설정 관리 |

## 설정 파일

| 파일 | 위치 | 용도 |
|------|------|------|
| `CLAUDE.md` | 프로젝트 루트 | 프로젝트별 지침/컨텍스트 |
| `~/.claude/settings.json` | 홈 디렉토리 | 전역 설정 |
| `.claude/settings.json` | 프로젝트 | 프로젝트별 설정 |
| `~/.claude/keybindings.json` | 홈 디렉토리 | 키바인딩 커스터마이징 |

## 권한 모드

| 모드 | 설명 |
|------|------|
| `--allowedTools` | 특정 도구만 자동 허용 |
| `--dangerously-skip-permissions` | 모든 권한 체크 스킵 (주의) |
| `/permissions` | 대화 중 권한 설정 변경 |

## 키보드 단축키

| 단축키 | 설명 |
|--------|------|
| `Enter` | 메시지 전송 |
| `Shift+Enter` | 줄바꿈 |
| `Ctrl+C` | 현재 작업 중단 |
| `Ctrl+D` | 대화 종료 |
| `Escape` | 실행 취소 / 입력 초기화 |
| `Tab` | 파일 경로 자동완성 |

## MCP (Model Context Protocol)

| 명령어 | 설명 |
|--------|------|
| `/mcp` | 연결된 MCP 서버 상태 확인 |
| `claude mcp add <name> <command>` | MCP 서버 추가 |
| `claude mcp remove <name>` | MCP 서버 제거 |
| `claude mcp list` | 등록된 MCP 서버 목록 |
