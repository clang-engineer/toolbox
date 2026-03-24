# Elasticsearch 데이터 로드 API

커스텀 로드 엔드포인트(`/api/load`)를 통해 ES 인덱스에 데이터를 적재하는 방법.

## 인덱스 종류

| 인덱스 | 용도 |
|--------|------|
| `exm_fun_exrs_cnte` | 기능 |
| `exm_rad_exrs_cnte` | 영상 |

## 적재 요청

```bash
curl -X POST http://localhost:18084/api/load \
  -H "Content-Type: application/json" \
  -d '{
    "index": "exm_rad_exrs_cnte",
    "isInitialize": true,
    "deleteDoc": false,
    "type": "LOAD",
    "startDate": "1990-01-01",
    "endDate": "2030-12-31"
  }'
```

| 파라미터 | 설명 |
|----------|------|
| `index` | 대상 인덱스 |
| `isInitialize` | 초기화 여부 |
| `deleteDoc` | 기존 문서 삭제 후 적재 |
| `type` | 작업 유형 (`LOAD`) |
| `startDate` / `endDate` | 적재 대상 기간 |

## 적재 확인

```bash
# 문서 수 확인
curl -X GET "http://localhost:9200/exm_rad_exrs_cnte/_count"
curl -X GET "http://localhost:9200/exm_fun_exrs_cnte/_count"
```
