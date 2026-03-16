#!/bin/bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
. "$DIR/config.env"

usage() {
    echo "Usage: $0 [--ip] [--dns] [--mac] [--route] [--all]"
    echo ""
    echo "  --ip      고정 IP 설정 ($IP_ADDR)"
    echo "  --dns     DNS 설정 ($DNS1, $DNS2)"
    echo "  --mac     MAC 주소 변경 ($MAC_ADDR)"
    echo "  --route   라우팅 테이블 재설정"
    echo "  --all     위 항목 모두 실행"
    echo ""
    echo "  옵션 없이 실행 시 --ip --dns --route 만 적용"
}

do_ip=false
do_dns=false
do_mac=false
do_route=false

if [ $# -eq 0 ]; then
    do_ip=true; do_dns=true; do_route=true
fi

for arg in "$@"; do
    case "$arg" in
        --ip)    do_ip=true ;;
        --dns)   do_dns=true ;;
        --mac)   do_mac=true ;;
        --route) do_route=true ;;
        --all)   do_ip=true; do_dns=true; do_mac=true; do_route=true ;;
        -h|--help) usage; exit 0 ;;
        *) echo "알 수 없는 옵션: $arg"; usage; exit 1 ;;
    esac
done

if $do_ip; then
    echo "=============== 고정 IP 설정 ==============="
    echo "IP: $IP_ADDR / $SUBNET / GW: $GATEWAY"
    sudo networksetup -setmanual "$WIFI_IF" "$IP_ADDR" "$SUBNET" "$GATEWAY"
fi

if $do_dns; then
    echo "=============== DNS 설정 ==============="
    echo "DNS: $DNS1, $DNS2"
    sudo networksetup -setdnsservers "$WIFI_IF" "$DNS1" "$DNS2"
fi

if $do_mac; then
    echo "=============== MAC 주소 설정 ==============="
    echo "MAC >>> $MAC_ADDR"
    sudo ifconfig en0 ether "$MAC_ADDR"
fi

if $do_route; then
    echo "=============== Routing 삭제 ==============="
    sh "$DIR/routing-delete.sh"
    sleep 1

    echo "=============== Routing 추가 ==============="
    sh "$DIR/routing-add.sh"
fi

echo "=============== SNUH 네트워크 세팅 완료 ==============="
