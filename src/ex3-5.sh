#!/bin/bash

run_ls() {
    opts="$1"
    echo "=== ls $opts 실행 결과 ==="
    eval ls $opts
    echo "=========================="
}

run_pwd() {
    echo "=== pwd 실행 결과 ==="
    pwd
    echo "======================"
}

run_date() {
    echo "=== date 실행 결과 ==="
    date
    echo "======================"
}

while true; do
    echo "======================"
    echo "1) ls 실행"
    echo "2) pwd 실행"
    echo "3) date 실행"
    echo "4) 종료"
    echo "======================"
    read -p "메뉴 선택: " choice
    
    case "$choice" in
        1)
            read -p "ls 옵션 입력: " opt
            run_ls "$opt"
            ;;
        2) run_pwd ;;
        3) run_date ;;
        4) echo "종료합니다."; exit 0 ;;
        *) echo "잘못된 입력입니다." ;;
    esac

    echo
done
