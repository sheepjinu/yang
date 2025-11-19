#!/bin/bash

scores=()   # 점수들을 저장할 배열

add_score() {
    read -p "추가할 점수 입력 (0~100): " s

    # 정수인지 확인
    if ! [[ "$s" =~ ^[0-9]+$ ]]; then
        echo "오류: 정수 점수만 입력하세요."
        return
    fi

    # 범위 체크
    if [ "$s" -lt 0 ] || [ "$s" -gt 100 ]; then
        echo "오류: 점수는 0~100 사이여야 합니다."
        return
    fi

    scores+=("$s")
    echo "점수 $s 추가 완료."
}

show_scores() {
    if [ ${#scores[@]} -eq 0 ]; then
        echo "입력된 점수가 없습니다."
        return
    fi

    echo "입력된 모든 점수:"
    for i in "${!scores[@]}"; do
        idx=$((i+1))
        echo "$idx) ${scores[$i]}"
    done
}

calc_average() {
    if [ ${#scores[@]} -eq 0 ]; then
        echo "점수가 하나도 없어서 평균을 계산할 수 없습니다."
        return 1
    fi

    sum=0
    for s in "${scores[@]}"; do
        sum=$((sum + s))
    done

    count=${#scores[@]}
    avg=$(echo "scale=2; $sum / $count" | bc -l)
    echo "평균 점수: $avg"
    # 함수 밖에서도 쓰게 전역 변수로 남겨두기
    LAST_AVG=$avg
    return 0
}

convert_gpa() {
    # 우선 평균이 없는 상태라면 계산 시도
    if [ -z "$LAST_AVG" ]; then
        calc_average || return
    fi

    avg=$LAST_AVG

    # 평균 점수 → GPA
    # 90~100: 4.0, 80~89: 3.0, 70~79: 2.0, 60~69: 1.0, 그 외 0.0
    if (( $(echo "$avg >= 90" | bc -l) )); then
        gpa="4.0"
    elif (( $(echo "$avg >= 80" | bc -l) )); then
        gpa="3.0"
    elif (( $(echo "$avg >= 70" | bc -l) )); then
        gpa="2.0"
    elif (( $(echo "$avg >= 60" | bc -l) )); then
        gpa="1.0"
    else
        gpa="0.0"
    fi

    echo "평균 점수 $avg 의 GPA: $gpa"
}

while true; do
    echo "======================="
    echo "1) 과목 성적 추가"
    echo "2) 입력된 모든 점수 보기"
    echo "3) 평균 점수 확인"
    echo "4) 평균 등급(GPA) 변환"
    echo "5) 종료"
    echo "======================="
    read -p "메뉴 선택(1-5): " choice

    case "$choice" in
        1) add_score ;;
        2) show_scores ;;
        3) calc_average ;;
        4) convert_gpa ;;
        5) echo "프로그램을 종료합니다."; break ;;
        *) echo "잘못된 입력입니다. 1~5 중에서 선택하세요." ;;
    esac

    echo
done
