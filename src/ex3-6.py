#!/usr/bin/env python

import sys

print("=== Python 실행파일 시작 ===")

args = sys.argv[1:]  # 첫 번째는 파일 이름이니까 제외

print(f"받은 인자 개수: {len(args)}")

for i, a in enumerate(args, start=1):
    print(f"{i}번째 인자: {a}")

print("=== Python 실행파일 끝 ===")
