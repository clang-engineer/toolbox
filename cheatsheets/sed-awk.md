# sed & awk Cheatsheet

## sed (Stream Editor)

스트림 편집기. 텍스트를 라인 단위로 검색/치환/삽입/삭제.

### 기본 사용법

```sh
sed [옵션] '명령' 파일명
```

### 치환

```sh
# 첫 번째만 치환
sed 's/apple/orange/' input.txt

# 전체 치환 (g 플래그)
sed 's/apple/orange/g' input.txt

# 원본 파일 직접 수정
sed -i 's/apple/orange/g' input.txt

# macOS에서 원본 수정 (백업 없이)
sed -i '' 's/apple/orange/g' input.txt
```

### 삽입/삭제

```sh
# 라인마다 끝에 ; 추가
sed 's/$/;/' input.txt

# 특정 라인 삭제
sed '3d' input.txt           # 3번째 줄 삭제
sed '/pattern/d' input.txt   # 패턴 매칭 줄 삭제

# 빈 줄 삭제
sed '/^$/d' input.txt
```

---

## awk (Pattern Scanning & Processing)

텍스트를 필드 단위로 처리. 조건문/반복문/계산 지원.

### 기본 사용법

```sh
awk '패턴 { 액션 }' 파일명
```

### 필드 출력

```sh
# 첫 번째 필드 출력
awk '{ print $1 }' input.txt

# 여러 필드
awk '{ print $1, $3 }' input.txt

# 전체 라인
awk '{ print $0 }' input.txt
```

### 조건 필터링

```sh
# 두 번째 필드가 'apple'인 라인
awk '$2 == "apple" { print }' input.txt

# 세 번째 필드가 100 이상
awk '$3 >= 100 { print $1, $3 }' input.txt
```

### 계산

```sh
# 합계
awk '{ sum += $1 + $2 } END { print sum }' input.txt

# 라인 수
awk 'END { print NR }' input.txt
```

### CSV 처리

```sh
# CSV에서 특정 필드 출력
awk -F, '{ print $3 }' input.csv

# 구분자 지정 출력
awk -F: '{ print $1, $3 }' /etc/passwd
```

---

## sed vs awk

| | sed | awk |
|---|---|---|
| 처리 단위 | 라인 | 라인 + 필드 |
| 강점 | 간단한 치환/삽입/삭제 | 데이터 분석, 계산, 보고서 |
| 프로그래밍 | 제한적 | 조건문, 반복문 지원 |
