#!/bin/bash

if [ $# -lt 2 ]; then 
	echo "사용법: $0 인자1 인자2 [인자3 ...]"
	exit 1

fi

echo  "--ex3-6.sh 시작"
echo "받은 인자: $@"

python3 "$(dirname "$0")/ex3-6.py" "$@"

echo "--ex3-6.sh 끝"
