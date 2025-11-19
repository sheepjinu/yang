#!/bin/bash

if [ $# -lt 2 ]; then
    echo "사용법: $0 점수1 점수2 [점수3 ...]"
    exit 1
fi

sum=0
count=0

echo "각 과목 점수 및 등급"
echo "---------------------------"

for score in "$@"
do
    # 정수인지 체크
    if ! [[ "$score" =~ ^[0-9]+$ ]]; then
        echo "오류: 정수 점수만 입력하세요. (입력값: $score)"
        exit 1
    fi

    # 0~100 범위 체크
    if [ "$score" -lt 0 ] || [ "$score" -gt 100 ]; then
        echo "오류: 점수는 0~100 사이여야 합니다. (입력값: $score)"
        exit 1
    fi

    # 등급 결정
    if [ "$score" -ge 90 ]; then
        grade="A"
    else
        grade="B"
    fi

    echo "점수: $score  →  등급: $grade"

    sum=$((sum + score))
    count=$((count + 1))
done

echo "---------------------------"

# 평균 점수(실수) 계산
avg=$(echo "scale=2; $sum / $count" | bc -l)

# 평균 등급
if (( $(echo "$avg >= 90" | bc -l) )); then
    avg_grade="A"
else
    avg_grade="B"
fi

echo "평균 점수: $avg"
echo "평균 등급: $avg_grade"
