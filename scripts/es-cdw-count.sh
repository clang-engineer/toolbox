#!/usr/bin/env bash
# CDW 검사/진료기록 Elasticsearch 인덱스 문서 수 조회
# Usage: bash es-cdw-count.sh [ES_HOST]

set -euo pipefail

ES_HOST="${1:-http://localhost:9200}"

declare -A labels

labels[exm_pth_exrs_cnte]="병리검사 검사결과"
labels[exm_fun_exrs_cnte]="기능검사 검사결과"
labels[exm_rad_exrs_cnte]="영상검사 검사결과"
labels[mdrc_cnte_dept]="진료기록 진료과"
labels[mdrc_cnte_dgns]="진료기록 진단"
labels[mdrc_cnte_pact]="진료기록 환자행위"
labels[mdrc_cnte_srgr]="진료기록 수술"

for idx in \
  exm_pth_exrs_cnte \
  exm_fun_exrs_cnte \
  exm_rad_exrs_cnte \
  mdrc_cnte_dept \
  mdrc_cnte_dgns \
  mdrc_cnte_pact \
  mdrc_cnte_srgr
do
  echo "===== $idx (${labels[$idx]}) ====="
  curl -s "${ES_HOST}/${idx}/_count"
  echo ""
done
