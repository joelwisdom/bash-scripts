#!/bin/bash
# function to calculate and return nth value in fibonacci sequence
n=$1

fib() {
    n=$1
    if (( n == 0)); then
        echo 0
    elif (( n == 1 )); then
        echo 1
    else
        a=0
        b=1
        i=2
        fib=0
        while (( i <= n )); do
            fib=$((a + b))
            a=$b
            b=$fib
            ((i++))
        done
        echo $fib
    fi
}

fib $n
