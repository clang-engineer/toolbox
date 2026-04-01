---
layout: til
title: "Java volatile vs static 차이 - 멀티스레드 환경에서의 변수 관리"
date: 2026-04-01
categories: [java]
tags: [volatile, static, multithreading, singleton, spring]
---

`static`과 `volatile`은 완전히 다른 개념이다. 멀티스레드 환경에서 변수를 다룰 때 둘의 역할을 정확히 알아야 한다.

## 핵심 차이

```
static    → 변수가 어디에 속하냐 (클래스 vs 인스턴스)
volatile  → 변수를 어디서 읽냐 (메인 메모리 vs CPU 캐시)
```

## 스레드의 메모리 구조

```
스레드 A                    스레드 B
┌──────────┐               ┌──────────┐
│  Stack A │               │  Stack B │   ← 각자 별도 (지역변수, 매개변수)
│  CPU캐시A│               │  CPU캐시B│   ← 각자 별도 (여기가 문제)
└────┬─────┘               └────┬─────┘
     │                          │
     └──────────┬───────────────┘
          ┌─────┴─────┐
          │    Heap    │   ← 공유 (인스턴스 변수, static 변수)
          │  Text/Data │   ← 공유 (클래스 정보, 상수)
          └───────────┘
```

- **스택의 지역변수**: 스레드마다 별도 → `volatile` 필요 없음 (공유 안 함)
- **힙의 인스턴스/static 변수**: 공유하지만, 각 CPU가 캐시에 복사본을 들고 있을 수 있음

## volatile이 필요한 이유

힙의 공유 변수를 CPU가 자기 캐시에 복사해두는 게 문제다. 메뉴판이 1개여도 직원들이 각자 메모해서 들고 다니는 것과 같다.

- `volatile` 없으면: 스레드 A가 값을 바꿔도, 스레드 B는 자기 CPU 캐시(옛날 값)를 계속 봄
- `volatile` 있으면: CPU 캐시 무시, 항상 메인 메모리(힙)에서 직접 읽음 → 최신 값 보장

## volatile 사용 예시

```java
// 1. 일반 클래스 - 스레드 간 플래그 공유
public class Worker implements Runnable {
    private volatile boolean running = true;

    public void run() {
        while (running) { // 다른 스레드가 stop() 호출하면 즉시 반영
            doWork();
        }
    }

    public void stop() {
        running = false;
    }
}

// 2. Spring 싱글톤 Bean - 인메모리 캐싱
@Service
public class DashboardService {
    private static final long CACHE_TTL_MS = 60 * 60 * 1000L; // 상수: static final
    private volatile DashboardResponse cachedResponse;          // 캐시: volatile
    private volatile long cacheTimestamp;
}
```

**핵심: `volatile`은 Spring Bean 전용이 아니라, 여러 스레드가 하나의 변수를 읽고 쓰는 모든 상황에서 필요하다.**

## 싱글톤인데 상수에 static을 쓰는 이유

싱글톤이면 어차피 인스턴스 1개라 실질적 차이는 없지만:
1. **의도 표현** - "이 값은 인스턴스와 무관하다"
2. **안전장치** - 스코프가 바뀌어도(프로토타입 등) 안전하게 동작
3. **관례** - Logger, 상수는 `private static final`이 표준

## 정리

| 용도 | 키워드 | 이유 |
|------|--------|------|
| 상수, Logger | `static final` | 인스턴스 무관, 불변, 관례 |
| 멀티스레드에서 변하는 값 | `volatile` | CPU 캐시 무시, 최신 값 보장 |
| 둘 다 필요할 때 | `static volatile` | 클래스 소속 + 최신 값 보장 |

## 조합 예시

```java
// 1. static final - 절대 안 바뀌는 상수
private static final Logger log = LoggerFactory.getLogger(MyService.class);
private static final int MAX_RETRY = 3;

// 2. volatile - 싱글톤 Bean에서 변하는 공유 값
private volatile String cachedToken;

// 3. static volatile - 유틸 클래스에서 여러 스레드가 공유하는 플래그
public class AppStatus {
    private static volatile boolean initialized = false;

    public static void init() {
        // 무거운 초기화 작업
        initialized = true;  // 모든 스레드가 즉시 true를 봄
    }

    public static boolean isReady() {
        return initialized;
    }
}

// 4. static (non-volatile) - 스레드 안전이 필요 없는 유틸 상수
public class DateUtil {
    private static final DateTimeFormatter FORMATTER =
        DateTimeFormatter.ofPattern("yyyy-MM-dd");
}
```

**판단 기준:**
- 값이 안 바뀜 → `static final`
- 값이 바뀜 + 멀티스레드에서 공유 → `volatile`
- 값이 바뀜 + 클래스 레벨 접근 필요 + 멀티스레드 → `static volatile`
