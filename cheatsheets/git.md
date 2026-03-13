# Git Cheatsheet

## 되돌리기

```bash
# 마지막 커밋 메시지 수정
git commit --amend -m "new message"

# 마지막 커밋 취소 (변경사항 유지)
git reset --soft HEAD~1

# 특정 파일만 되돌리기
git checkout -- <file>

# staged → unstaged
git restore --staged <file>
```

## 브랜치

```bash
# 리모트 브랜치 체크아웃
git switch -c <local> origin/<remote>

# 머지된 브랜치 정리
git branch --merged | grep -v "main\|master" | xargs git branch -d

# 브랜치 이름 변경
git branch -m <old> <new>
```

## Stash

```bash
git stash                     # 임시 저장
git stash -u                  # untracked 포함
git stash list                # 목록
git stash pop                 # 꺼내기 (삭제)
git stash apply stash@{n}    # 꺼내기 (유지)
git stash drop stash@{n}     # 삭제
```

## 로그 & 검색

```bash
# 한줄 로그 + 그래프
git log --oneline --graph --all

# 특정 문자열이 변경된 커밋 찾기
git log -S "검색어" --oneline

# 특정 파일의 변경 이력
git log --follow -p -- <file>

# 누가 이 줄을 썼는지
git blame <file>
```

## 기타

```bash
# 특정 커밋의 변경사항 보기
git show <commit>

# 리모트 URL 변경
git remote set-url origin <url>

# .gitignore에 이미 추적 중인 파일 제외
git rm --cached <file>

# 빈 디렉토리 유지 (.gitkeep)
touch dir/.gitkeep
```
