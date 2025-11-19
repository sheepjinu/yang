#!/bin/bash

echo "입력된 x 값들: $@"

for x in "$@"
do
    # y = 0.5 * x^2 계산 (실수 계산 위해 bc 사용)
    y=$(echo "0.5 * ($x * $x)" | bc -l)

    echo "x = $x  →  y = $y"
done
