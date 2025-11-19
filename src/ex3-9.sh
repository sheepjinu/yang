#!/bin/bash

DB_FILE="DB.txt"

# DB 파일이 없으면 생성
if [ ! -f "$DB_FILE" ]; then
    touch "$DB_FILE"
fi

add_member() {
    echo "=== 팀원 정보 추가 ==="
    read -p "이름: " name
    read -p "생일 (예: 2005-01-23): " birth
    read -p "전화번호: " phone

    echo "MEMBER|$name|$birth|$phone" >> "$DB_FILE"
    echo "팀원 정보가 저장되었습니다."
}

add_log() {
    echo "=== 팀원과 한 일 기록 ==="
    read -p "날짜 (예: 2025-11-20): " date
    read -p "팀원 이름: " name
    read -p "수행 내용: " content

    echo "LOG|$date|$name|$content" >> "$DB_FILE"
    echo "수행 내용이 저장되었습니다."
}

search_member() {
    echo "=== 팀원 검색 ==="
    read -p "검색할 팀원 이름: " name

    found_member=0
    found_log=0

    echo "--- 기본 정보 ---"
    while IFS='|' read -r type n birth phone; do
        [ "$type" = "MEMBER" ] || continue
        if [ "$n" = "$name" ]; then
            echo "이름: $n, 생일: $birth, 전화번호: $phone"
            found_member=1
        fi
    done < "$DB_FILE"

    if [ $found_member -eq 0 ]; then
        echo "해당 이름의 팀원 정보가 없습니다."
    fi

    echo "--- 수행 기록 ---"
    while IFS='|' read -r type date n content; do
        [ "$type" = "LOG" ] || continue
        if [ "$n" = "$name" ]; then
            echo "날짜: $date, 내용: $content"
            found_log=1
        fi
    done < "$DB_FILE"

    if [ $found_log -eq 0 ]; then
        echo "해당 팀원의 수행 기록이 없습니다."
    fi
}

search_log_by_date() {
    echo "=== 수행 내용 검색 (날짜 기준) ==="
    read -p "검색할 날짜 (예: 2025-11-20): " date

    found=0
    while IFS='|' read -r type d name content; do
        [ "$type" = "LOG" ] || continue
        if [ "$d" = "$date" ]; then
            echo "이름: $name, 내용: $content"
            found=1
        fi
    done < "$DB_FILE"

    if [ $found -eq 0 ]; then
        echo "해당 날짜의 수행 기록이 없습니다."
    fi
}

while true; do
    echo "==========================="
    echo "1) 팀원 정보 추가"
    echo "2) 팀원과 한 일 기록"
    echo "3) 팀원 검색"
    echo "4) 수행 내용 검색"
    echo "5) 종료"
    echo "==========================="
    read -p "메뉴 선택(1~5): " choice

    case "$choice" in
        1) add_member ;;
        2) add_log ;;
        3) search_member ;;
        4) search_log_by_date ;;
        5) echo "프로그램을 종료합니다."; exit 0 ;;
        *) echo "잘못된 입력입니다. 1~5 중에서 선택하세요." ;;
    esac

    echo
done

