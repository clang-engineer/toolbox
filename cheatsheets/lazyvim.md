# LazyVim Cheatsheet

> `<leader>` 기본값: `Space`
> 모드: `n`(Normal) `i`(Insert) `v`(Visual) `x`(Visual+Select) `o`(Operator) `t`(Terminal) `s`(Select)

## 이동

| 키 | 모드 | 설명 |
|------|------|------|
| `j` / `k` | n, x | Count 없으면 `gj`/`gk` (줄바꿈 단위), 있으면 `j`/`k` |
| `<C-h/j/k/l>` | n | 윈도우 간 이동 (좌/하/상/우) |
| `<C-Up/Down/Left/Right>` | n | 창 크기 조절 (+/-2) |

## 줄 이동

| 키 | 모드 | 설명 |
|------|------|------|
| `<A-j>` | n, i, v | 현재 줄/선택 영역 아래로 |
| `<A-k>` | n, i, v | 현재 줄/선택 영역 위로 |

## 버퍼

| 키 | 모드 | 설명 |
|------|------|------|
| `<S-h>` / `[b` | n | 이전 버퍼 |
| `<S-l>` / `]b` | n | 다음 버퍼 |
| `<leader>bb` | n | 이전 버퍼로 전환 |
| `<leader>bd` | n | 현재 버퍼 닫기 |
| `<leader>bo` | n | 다른 버퍼 모두 닫기 |
| `<leader>bD` | n | 버퍼 + 윈도우 함께 닫기 |

## 검색

| 키 | 모드 | 설명 |
|------|------|------|
| `<Esc>` | i, n, s | 검색 하이라이트 제거 + snippet 중단 |
| `n` / `N` | n, x, o | 다음/이전 검색 결과 (zv 포함) |
| `<leader>ur` | n | 검색/디프 업데이트/리드로우 |

## 저장 & Undo

| 키 | 모드 | 설명 |
|------|------|------|
| `<C-s>` | i, x, n, s | 파일 저장 |
| `, . ;` | i | 입력 중 undo 포인트 추가 |
| `<` / `>` | v | 인덴트 (선택 유지) |

## 주석

| 키 | 모드 | 설명 |
|------|------|------|
| `gco` | n | 현재 줄 아래에 주석 추가 |
| `gcO` | n | 현재 줄 위에 주석 추가 |

## 파일 & 창

| 키 | 모드 | 설명 |
|------|------|------|
| `<leader>fn` | n | 새 파일 |
| `<leader>-` | n | 아래로 split |
| `<leader>\|` | n | 오른쪽으로 split |
| `<leader>wd` | n | 창 닫기 |
| `<leader>wm` / `<leader>uZ` | n | 창 줌 토글 |
| `<leader>uz` | n | Zen 모드 토글 |
| `<leader>qq` | n | 모든 창 종료 |
| `<leader>l` | n | Lazy UI 열기 |

## Quickfix / Location List

| 키 | 모드 | 설명 |
|------|------|------|
| `<leader>xl` | n | Location List 토글 |
| `<leader>xq` | n | Quickfix List 토글 |
| `[q` / `]q` | n | 이전/다음 Quickfix |

## 포맷팅 & 진단

| 키 | 모드 | 설명 |
|------|------|------|
| `<leader>cf` | n, v | 강제 포맷 |
| `<leader>cd` | n | 현재 줄 진단 float |
| `[d` / `]d` | n | 이전/다음 진단 |
| `[e` / `]e` | n | 이전/다음 에러 |
| `[w` / `]w` | n | 이전/다음 워닝 |

## 옵션 토글

| 키 | 설명 |
|------|------|
| `<leader>uf` / `uF` | 포맷 토글 / 강제 포맷 토글 |
| `<leader>us` | 스펠링 토글 |
| `<leader>uw` | 줄 바꿈(wrap) 토글 |
| `<leader>ul` / `uL` | 라인 번호 / 상대 번호 토글 |
| `<leader>ud` / `uD` | 진단 / Dim 토글 |
| `<leader>uc` | conceallevel 토글 |
| `<leader>uT` | Treesitter 토글 |
| `<leader>ub` | 배경 light/dark 토글 |
| `<leader>ug` | Indent guide 토글 |
| `<leader>uh` | LSP Inlay Hints 토글 |
| `<leader>ua` / `uS` | 애니메이션 / 스크롤 애니메이션 토글 |

## Git

| 키 | 모드 | 설명 |
|------|------|------|
| `<leader>gg` | n | Lazygit (Root Dir) |
| `<leader>gG` | n | Lazygit (cwd) |
| `<leader>gl` / `gL` | n | Git Log (Root Dir / cwd) |
| `<leader>gb` | n | 현재 줄 Git blame |
| `<leader>gf` | n | 현재 파일 Git history |
| `<leader>gB` | n, x | Git 브라우저 열기 |

## Terminal

| 키 | 모드 | 설명 |
|------|------|------|
| `<leader>ft` / `fT` | n | 터미널 열기 (Root Dir / cwd) |
| `<C-/>` | n | 터미널 열기 |
| `<C-/>` | t | 터미널 닫기 |

## Tabs

| 키 | 모드 | 설명 |
|------|------|------|
| `<leader><tab><tab>` | n | 새 탭 |
| `<leader><tab>d` | n | 탭 닫기 |
| `<leader><tab>]` / `[` | n | 다음/이전 탭 |
| `<leader><tab>f` / `l` | n | 첫 번째/마지막 탭 |
| `<leader><tab>o` | n | 다른 탭 모두 닫기 |

## 기타

| 키 | 모드 | 설명 |
|------|------|------|
| `<leader>K` | n | Keywordprg 실행 |
| `<leader>ui` | n | 커서 아래 하이라이트 확인 |
| `<leader>uI` | n | Treesitter Inspect Tree |
| `<leader>L` | n | LazyVim Changelog |
