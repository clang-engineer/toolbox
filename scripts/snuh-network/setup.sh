#!/bin/bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
. "$DIR/config.env"

echo "=============== Routing 삭제 ==============="
sh "$DIR/routing-delete.sh"
sleep 1

echo "=============== Routing 추가 ==============="
sh "$DIR/routing-add.sh"
sleep 1

if [ "$1" = "--mac" ]; then
    echo "=============== MAC 주소 설정 ==============="
    echo "MAC >>> $MAC_ADDR"
    sudo ifconfig en0 ether "$MAC_ADDR"
fi

echo "=============== SNUH 네트워크 세팅 완료 ==============="
