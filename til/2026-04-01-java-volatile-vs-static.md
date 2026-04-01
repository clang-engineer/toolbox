---
layout: til
title: "Java volatile vs static 차이 - 싱글톤 Bean에서의 멀티스레드 캐싱"
date: 2026-04-01
categories: [java]
tags: [volatile, static, multithreading, singleton, spring]
---

`static`과 `volatile`은 완전히 다른 개념이다. 싱글톤 Bean에서 인메모리 캐싱 시 둘의 역할을 정확히 알아야 한다.

## 핵심 차이

```
static    → 변수가 어디에 속하냐 (클래스 vs 인스턴스)
volatile  → 변수를 어디서 읽냐 (메인 메모리 vs CPU 캐시)
```

## volatile이 필요한 이유

CPU는 성능을 위해 변수를 자기 캐시에 복사해둔다. 메뉴판이 1개여도 직원들이 각자 메모해서 들고 다니는 것과 같다.

- `volatile` 없으면: 스레드 A가 값을 바꿔도, 스레드 B는 자기 CPU 캐시(옛날 값)를 계속 봄
- `volatile` 있으면: 항상 메인 메모리에서 직접 읽음 → 최신 값 보장

## 싱글톤 Bean에서의 사용 패턴

```java
@Service // 싱글톤 → 인스턴스 1개 → static 불필요
public class DashboardService {
    // 상수: static final (관례 + 의도 표현 + 스코프 안전)
    private static final long CACHE_TTL_MS = 60 * 60 * 1000L;

    // 변하는 캐시 값: volatile (멀티스레드 최신 값 보장)
    private volatile DashboardResponse cachedResponse;
    private volatile long cacheTimestamp;
}
```

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
- 값이 바뀜 + 싱글톤 Bean → `volatile`
- 값이 바뀜 + 인스턴스 여러 개 or static 메서드에서 접근 → `static volatile`
