# GDB Cheatsheet

## 설치

```sh
brew install gdb        # macOS
sudo apt install gdb    # Ubuntu/Debian
```

## 사전 준비

컴파일 시 `-g` 옵션으로 디버그 정보 포함:

```sh
gcc -g test.c -o test
g++ -g main.cpp -o main
```

## 실행

```sh
gdb <프로그램명>
gdb --args <프로그램명> <arg1> <arg2>    # 인자 전달
```

## 중단점 (Breakpoint)

### 설정

```sh
break <함수이름>
break <라인번호>
break <파일이름:라인번호>
break <파일이름:함수이름>
break <...> if <condition>    # 조건부 중단점
```

### 확인 / 삭제

```sh
info break                   # 중단점 목록 (약어: i b)

clear <함수이름>              # 특정 중단점 삭제
clear <라인번호>
delete                       # 모든 중단점 삭제
delete <번호>                 # 번호로 삭제
```

### 활성화 / 비활성화

```sh
enable <번호>
disable <번호>
```

## 실행 제어

| 명령어 | 설명 |
|--------|------|
| `run` (`r`) | 프로세스 실행/재실행 |
| `continue` (`c`) | 다음 중단점까지 재개 |
| `next` (`n`) | 한 줄 실행 (함수 내부 진입 X) |
| `step` (`s`) | 한 줄 실행 (함수 내부 진입 O) |
| `finish` | 현재 함수 완료 후 리턴값 출력 |
| `return` | 현재 함수를 실행하지 않고 빠져나감 |
| `return <값>` | 지정한 값을 리턴하며 빠져나감 |

## Call Stack

```sh
backtrace              # 콜 스택 확인 (약어: bt)
bt full                # 지역변수 포함 출력
bt <N>                 # 상위 N개만 출력
frame <N>              # N번 프레임으로 이동
up / down              # 프레임 이동
```

## 값 출력 / 변경

### print

```sh
print <변수>            # 변수 값 출력 (약어: p)
p *<포인터>             # 포인터 역참조
p arr[n]               # 배열 요소
p/x <변수>             # 16진수 출력
p -pretty *<구조체>    # 구조체 보기 좋게 출력
set var <변수>=<값>     # 변수 값 변경
```

### display

```sh
display <변수>          # 매 step/next마다 자동 출력
info display           # display 목록
undisplay <번호>        # display 해제
```

## 소스 코드

```sh
list                   # 현재 위치 소스 출력 (약어: l)
list <라인번호>
list <함수이름>
list <시작>,<끝>
set listsize <N>       # 출력 라인 수 설정
```

## 메모리 / 레지스터

```sh
x/<N><fmt><size> <주소>   # 메모리 검사 (예: x/16xb $rsp)
info registers            # 레지스터 확인 (약어: i r)
info locals               # 지역변수 확인
info args                 # 함수 인자 확인
```

## 워치포인트

```sh
watch <변수>              # 변수 값 변경 시 중단
rwatch <변수>             # 변수 읽기 시 중단
awatch <변수>             # 읽기/쓰기 시 중단
info watchpoints          # 워치포인트 목록
```
