#!/usr/bin/env bash
# PostgreSQL 데이터베이스를 pg_dump로 백업합니다.
# Usage: bash pg-backup.sh [옵션]

set -euo pipefail

# 기본값
HOST="localhost"
PORT="5432"
USERNAME="postgres"
DATABASE=""
SCHEMAS=()
BACKUP_DIR="./backup"
DRY_RUN=false
PG_DUMP_OPTIONS="--column-inserts --format=p --if-exists --create --clean"

usage() {
    cat <<EOF
Usage: $(basename "$0") [옵션]

PostgreSQL 데이터베이스를 pg_dump로 백업합니다.

옵션:
  -h, --host HOST        호스트 (기본: localhost)
  -p, --port PORT        포트 (기본: 5432)
  -U, --user USER        사용자 (기본: postgres)
  -d, --db DATABASE      데이터베이스명 (필수)
  -s, --schema SCHEMA    스키마 (여러 번 지정 가능)
  -o, --output DIR       백업 디렉토리 (기본: ./backup)
  --dry-run              실제 실행 없이 명령어만 출력
  --help                 이 도움말 출력
EOF
    exit 0
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--host) HOST="$2"; shift 2 ;;
        -p|--port) PORT="$2"; shift 2 ;;
        -U|--user) USERNAME="$2"; shift 2 ;;
        -d|--db) DATABASE="$2"; shift 2 ;;
        -s|--schema) SCHEMAS+=("$2"); shift 2 ;;
        -o|--output) BACKUP_DIR="$2"; shift 2 ;;
        --dry-run) DRY_RUN=true; shift ;;
        --help) usage ;;
        *) echo "알 수 없는 옵션: $1"; usage ;;
    esac
done

if [[ -z "$DATABASE" ]]; then
    echo "오류: 데이터베이스명(-d)은 필수입니다."
    echo ""
    usage
fi

# 백업 파일 경로 생성
DATE=$(date +%y%m%d%H%M%S)
FILENAME="${DATABASE}-${DATE}-dump.sql"
FILEPATH="${BACKUP_DIR}/${FILENAME}"

# 스키마 옵션 구성
SCHEMA_OPTS=""
for schema in "${SCHEMAS[@]+"${SCHEMAS[@]}"}"; do
    SCHEMA_OPTS="$SCHEMA_OPTS -n $schema"
done

CMD="pg_dump -U ${USERNAME} -h ${HOST} -p ${PORT} -d ${DATABASE}${SCHEMA_OPTS} --file=\"${FILEPATH}\" ${PG_DUMP_OPTIONS}"

echo "호스트:     ${HOST}:${PORT}"
echo "데이터베이스: ${DATABASE}"
if [[ ${#SCHEMAS[@]} -gt 0 ]]; then
    echo "스키마:     ${SCHEMAS[*]}"
fi
echo "백업 파일:  ${FILEPATH}"
echo "---"

if [[ "$DRY_RUN" == true ]]; then
    echo "[dry-run] 실행할 명령어:"
    echo "$CMD"
    exit 0
fi

# 백업 디렉토리 자동 생성
mkdir -p "$BACKUP_DIR"

echo "백업을 시작합니다..."
eval "$CMD"
echo "완료! → ${FILEPATH}"
