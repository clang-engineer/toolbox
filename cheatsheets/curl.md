# curl Cheatsheet

## 설치

```sh
brew install curl       # macOS
sudo apt install curl   # Ubuntu, Debian
sudo yum install curl   # CentOS, Fedora
```

## 기본 사용법

```sh
curl --help
curl --manual
```

## 주요 옵션

### -v (Verbose)

상세한 요청/응답 로그 표시:

```sh
curl -v https://example.com
```

### -H (Header)

요청 헤더 지정:

```sh
curl -H "Content-Type: application/json" -H "Authorization: Bearer <token>" https://example.com
```

### -d (Data)

POST 요청으로 데이터 전송:

```sh
curl -d 'key=value' -d 'foo=bar' https://example.com
curl -H 'Content-Type: application/json' -d '{"foo": "bar"}' https://example.com
```

### -i (Include)

응답 헤더를 함께 출력:

```sh
curl -i https://example.com
```

### -X (Method)

요청 메소드 지정:

```sh
curl -X PUT -d '{"key": "value"}' -H 'Content-Type: application/json' https://example.com
curl -X DELETE https://example.com/resource/1
curl -X PATCH -d '{"name": "new"}' -H 'Content-Type: application/json' https://example.com
```

### -F (Form)

multipart/form-data 형식 전송 (`@`로 파일 지정):

```sh
curl -F 'file=@/path/to/file' -F 'key=value' https://example.com
```

### -o / -O (Output)

파일 다운로드:

```sh
curl https://example.com > output.html           # 리다이렉션
curl -o output.html https://example.com           # 파일명 지정
curl -O https://example.com/image.jpg             # 원본 파일명 유지
curl -L -O https://example.com/file.tar.gz        # 리다이렉트 따라가며 다운로드
```

### -k (Insecure)

SSL 인증서 검증 무시 (사설 인증서 서버 테스트 시):

```sh
curl -k https://self-signed.example.com
```

### -L (Follow Redirects)

HTTP 리다이렉트 자동 따라감:

```sh
curl -L https://example.com
```

### -s (Silent) / -S (Show Error)

진행 표시 숨기기:

```sh
curl -s https://example.com                       # 조용한 모드
curl -sS https://example.com                      # 조용하지만 에러는 표시
curl -s https://api.example.com/data | jq .        # JSON 파이프라인에 유용
```

### -w (Write-out)

응답 정보 출력:

```sh
curl -s -o /dev/null -w "%{http_code}" https://example.com           # HTTP 상태 코드만
curl -s -o /dev/null -w "time_total: %{time_total}s\n" https://example.com  # 응답 시간 측정
```

## 자주 쓰는 패턴

```sh
# REST API 호출
curl -s https://api.example.com/users | jq .

# Bearer 토큰 인증
curl -H "Authorization: Bearer $TOKEN" https://api.example.com/me

# 파일 업로드
curl -F "file=@report.pdf" https://example.com/upload

# 응답 시간 측정
curl -o /dev/null -s -w "DNS: %{time_namelookup}s\nConnect: %{time_connect}s\nTotal: %{time_total}s\n" https://example.com
```
