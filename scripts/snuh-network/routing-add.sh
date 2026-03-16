#!/bin/sh
# SNUH 라우팅 추가
DIR="$(cd "$(dirname "$0")" && pwd)"
. "$DIR/config.env"

grep -v '^\s*#' "$DIR/routes.conf" | grep -v '^\s*$' | while read -r line; do
    ip=$(echo "$line" | awk '{print $1}')
    comment=$(echo "$line" | sed 's/[^#]*#//')
    echo "[ADD] $ip ($comment)"
    sudo route -n add -host "$ip" "$GATEWAY"
done
