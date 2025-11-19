#!/bin/bash

show_user_info() {
    echo "====== 사용자 정보 ======"
    echo "현재 사용자: $(whoami)"
    echo "UID/GID 정보:"
    id
    echo "=========================="
}

show_cpu_gpu_info() {
    echo "====== CPU/GPU 사용률 ======"
    if command -v nvidia-smi &> /dev/null; then
        echo "[GPU 정보 - nvidia-smi]"
        nvidia-smi
    else
        echo "[GPU 없음 → CPU top 정보 표시]"
        top -b -n 1 | head -n 15
    fi
    echo "============================="
}

show_memory_info() {
    echo "====== 메모리 사용량 ======"
    free -h
    echo "=========================="
}

show_disk_info() {
    echo "====== 디스크 사용량 ======"
    df -h
    echo "=========================="
}

while true; do
    echo "--------------------------------"
    echo "1) 사용자 정보 확인"
    echo "2) CPU/GPU 사용률 확인"
    echo "3) 메모리 사용량 확인"
    echo "4) 디스크 사용량 확인"
    echo "5) 종료"
    echo "--------------------------------"
    read -p "메뉴 선택 (1~5): " choice

    case $choice in
        1) show_user_info ;;
        2) show_cpu_gpu_info ;;
        3) show_memory_info ;;
        4) show_disk_info ;;
        5) echo "프로그램을 종료합니다."; exit 0 ;;
        *) echo "잘못된 입력입니다. 1~5 중에 선택하세요." ;;
    esac

    echo
done

