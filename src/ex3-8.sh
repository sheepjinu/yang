#!/bin/bash

# 1. DB 폴더 존재 여부 확인 후 생성
if [ ! -d "DB" ]; then
    echo "DB 폴더가 없어 새로 생성합니다."
    mkdir DB
else
    echo "DB 폴더가 이미 존재합니다."
fi

# 2. DB 폴더 안에 임의의 파일 5개 만들기
echo "DB 폴더에 임의 파일 5개 생성합니다."
for i in {1..5}; do
    echo "This is file $i" > DB/file$i.txt
done

# 3. DB 폴더 압축 (zip 사용)
echo "DB 폴더를 DB.zip 으로 압축합니다."
zip -r DB.zip DB > /dev/null 2>&1
echo "압축 완료: DB.zip"

# 4. train 폴더 생성
if [ ! -d "train" ]; then
    echo "train 폴더를 생성합니다."
    mkdir train
else
    echo "train 폴더가 이미 존재합니다."
fi

# 5. train 폴더에 DB 안 파일들 링크 생성
echo "train 폴더 안에 DB 파일을 링크합니다."
for f in DB/*; do
    ln -sf "../$f" "train/$(basename $f)"
done

echo "완료! train 폴더 안에서 DB 파일을 링크로 접근할 수 있습니다."
echo "=== ex3-8 끝 ==="
