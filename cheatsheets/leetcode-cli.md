# LeetCode CLI Cheatsheet

> **Note**: 원본 [skygragon/leetcode-cli](https://github.com/skygragon/leetcode-cli)는 archived 상태.
> 대안: [leetcode-cli (Rust)](https://github.com/clearloop/leetcode-cli) — `cargo install leetcode-cli`

## 설치

```sh
npm install -g leetcode-cli     # Node.js 18+
```

## 로그인

```sh
leetcode user -l
```

> 로그인 실패 시 `~/.lc/leetcode/user.json`에 브라우저 쿠키를 직접 복사하여 입력.

## 문제 풀기

```sh
leetcode show <id>                          # 문제 확인
leetcode show <id> -g -l <lang>             # 풀이 파일 생성 (-x: 설명 포함)
leetcode show <id> -c                       # 코드 템플릿
leetcode show -q eL                         # Easy + Unlocked 랜덤 문제
leetcode test <file>                        # 테스트 실행
leetcode submit <file>                      # 제출
```

## 문제 검색

```sh
leetcode list                               # 전체 목록
leetcode list -q eL                         # Easy + Unlocked
leetcode list -q mL                         # Medium + Unlocked
leetcode list -t array                      # 태그 필터
```

> 쿼리 플래그: `e`(Easy) `m`(Medium) `h`(Hard) `d`(Done) `l`(Locked) `L`(Unlocked) `s`(Starred)

## 기타

```sh
leetcode stat                               # 풀이 통계
leetcode star <id>                          # 즐겨찾기
leetcode star -d <id>                       # 즐겨찾기 해제
leetcode cache                              # 캐시 목록
leetcode cache -d <id>                      # 캐시 삭제
```
