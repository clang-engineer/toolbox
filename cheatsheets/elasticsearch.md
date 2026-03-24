# Elasticsearch Cheatsheet

## 클러스터/노드 정보

| 명령어 | 설명 |
|--------|------|
| `curl http://HOST:9200` | 버전 및 노드 정보 확인 |
| `curl http://HOST:9200/_cluster/health?pretty` | 클러스터 상태 확인 (green/yellow/red) |
| `curl http://HOST:9200/_cluster/stats?pretty` | 클러스터 통계 |
| `curl http://HOST:9200/_cat/nodes?v` | 노드 목록 |
| `curl http://HOST:9200/_cat/indices?v` | 인덱스 목록 |
| `elasticsearch --version` | 서버 설치 버전 확인 |

## 문서 Count

```bash
# 인덱스 전체 문서 수 (정확한 값)
curl -X GET "http://HOST:9200/INDEX/_count"

# 조건부 count
curl -X GET "http://HOST:9200/INDEX/_count" \
  -H 'Content-Type: application/json' \
  -d '{
    "query": {
      "range": {
        "lsh_dtm": {
          "gte": "2026-03-01T00:00:00",
          "lte": "2026-03-01T23:59:59"
        }
      }
    }
  }'
```

> `_search`는 기본 10,000까지만 count (`"relation": "gte"`). 정확한 전체 수는 `_count` 사용.
> `_search`에서 정확한 수가 필요하면 `"track_total_hits": true` 추가 (느림).

## 문서 조회

```bash
# 기본 조회 (10건)
curl -X GET "http://HOST:9200/INDEX/_search?pretty"

# 조건 조회
curl -X GET "http://HOST:9200/INDEX/_search?pretty" \
  -H 'Content-Type: application/json' \
  -d '{
    "query": {
      "range": {
        "lsh_dtm": {
          "gte": "2026-03-01T00:00:00",
          "lte": "2026-03-01T23:59:59"
        }
      }
    }
  }'

# size 지정
curl -X GET "http://HOST:9200/INDEX/_search?size=5&pretty"
```

## 검색 쿼리

### match (부분 매칭)

단어 단위로 분석 후 매칭. 순서 무관, OR 조건.

```bash
curl -X GET "http://HOST:9200/INDEX/_search?pretty" \
  -H 'Content-Type: application/json' \
  -d '{
    "query": {
      "match": {
        "exrs_cnte": "mild as"
      }
    }
  }'

# _count와 조합
curl -X GET "http://HOST:9200/INDEX/_count" \
  -H 'Content-Type: application/json' \
  -d '{
    "query": {
      "match": {
        "exrs_cnte": "mild as"
      }
    }
  }'
```

### match_phrase (정확한 구문 매칭)

단어 순서까지 일치해야 매칭.

```bash
curl -X GET "http://HOST:9200/INDEX/_search?pretty" \
  -H 'Content-Type: application/json' \
  -d '{
    "query": {
      "match_phrase": {
        "exrs_cnte": "Mild As"
      }
    }
  }'
```

### match vs match_phrase 비교

| 쿼리 | `"mild as"` 입력 시 매칭 | 용도 |
|------|--------------------------|------|
| `match` | "mild" 또는 "as" 포함하면 매칭 (OR) | 넓은 검색 |
| `match` + `"operator": "and"` | "mild"과 "as" 모두 포함 (순서 무관) | 교집합 검색 |
| `match_phrase` | "mild as" 구문 그대로 매칭 (순서 일치) | 정확한 문구 검색 |

### bool 쿼리 (복합 조건)

```bash
curl -X GET "http://HOST:9200/INDEX/_search?pretty" \
  -H 'Content-Type: application/json' \
  -d '{
    "query": {
      "bool": {
        "must": [
          { "match_phrase": { "exrs_cnte": "Mild As" } }
        ],
        "filter": [
          { "range": { "lsh_dtm": { "gte": "2024-01-01", "lte": "2024-12-31" } } }
        ]
      }
    }
  }'
```

| bool 절 | 설명 |
|---------|------|
| `must` | AND 조건 (스코어 반영) |
| `should` | OR 조건 (스코어 반영) |
| `must_not` | NOT 조건 |
| `filter` | AND 조건 (스코어 무시, 캐싱됨 → 빠름) |

## Bulk 적재

```bash
# bulk 요청
curl -X POST "http://HOST:9200/_bulk?timeout=1m" \
  -H 'Content-Type: application/x-ndjson' \
  --data-binary @bulk_data.json
```

### Bulk 적재 확인 방법

```bash
# 1. 적재 전후 _count 비교
curl -X GET "http://HOST:9200/INDEX/_count"

# 2. 날짜 조건으로 이번 배치만 확인
curl -X GET "http://HOST:9200/INDEX/_count" \
  -H 'Content-Type: application/json' \
  -d '{"query":{"range":{"lsh_dtm":{"gte":"2026-03-01T00:00:00","lte":"2026-03-01T23:59:59"}}}}'
```

## Delete by Query

```bash
curl -X POST "http://HOST:9200/INDEX/_delete_by_query?refresh=true&conflicts=proceed" \
  -H 'Content-Type: application/json' \
  -d '{
    "query": {
      "range": {
        "lsh_dtm": {
          "gte": "2026-03-01T00:00:00",
          "lte": "2026-03-01T23:59:59"
        }
      }
    }
  }'
```

| 파라미터 | 설명 |
|----------|------|
| `refresh=true` | 삭제 후 즉시 검색 반영 |
| `conflicts=proceed` | 충돌 무시하고 계속 |
| `wait_for_completion=true` | 완료까지 대기 |
| `slices=auto` | 병렬 삭제 (성능 향상) |
| `timeout=1m` | 타임아웃 설정 |

## 로그 확인

```bash
# 실시간 로그 (기본 경로)
tail -f /var/log/elasticsearch/elasticsearch.log

# 에러만 필터
tail -f /var/log/elasticsearch/elasticsearch.log | grep -i error

# bulk 관련만
tail -f /var/log/elasticsearch/elasticsearch.log | grep -i bulk

# systemd 서비스 로그
journalctl -u elasticsearch -f

# Docker 환경
docker logs -f <container_name>

```

## 인덱스 관리

```bash
# 인덱스 생성
curl -X PUT "http://HOST:9200/INDEX"

# 인덱스 삭제
curl -X DELETE "http://HOST:9200/INDEX"

# 인덱스 설정 확인
curl -X GET "http://HOST:9200/INDEX/_settings?pretty"

# 매핑 확인
curl -X GET "http://HOST:9200/INDEX/_mapping?pretty"

# 인덱스 목록 (정렬)
curl -X GET "http://HOST:9200/_cat/indices?v&s=index"
```

## _cat API (운영 모니터링)

| 명령어 | 설명 |
|--------|------|
| `_cat/health?v` | 클러스터 상태 |
| `_cat/nodes?v` | 노드 목록 |
| `_cat/indices?v` | 인덱스 목록 |
| `_cat/shards?v` | 샤드 배치 상태 |
| `_cat/allocation?v` | 디스크 할당 |
| `_cat/thread_pool?v` | 스레드풀 상태 |
| `_cat/pending_tasks?v` | 대기 작업 |
