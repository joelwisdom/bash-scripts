#!/bin/bash

# Defaults
debug=false

# Parse args
while [[ $# -gt 0 ]]; do
    case "$1" in
    -o)
        operation=$2
        shift 2
        ;;
    -n)
        shift
        numbers=()
        while [[ "$1" != -* && $# -gt 0 ]]; do
            numbers+=("$1")
            shift
        done
        ;;
    -d)
        debug=true
        shift
        ;;
    *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
done

# Basic validation
if [[ -z "$operation" || ${#numbers[@]} -lt 2 ]]; then
    echo "Usage: $0 -o <+|-|*|%> -n <num1> <num2> ... [-d]"
    exit 1
fi

# Do the math
result=${numbers[0]}
for ((i = 1; i < ${#numbers[@]}; i++)); do
    num=${numbers[i]}
    case "$operation" in
    +) result=$((result + num)) ;;
    -) result=$((result - num)) ;;
    '*') result=$((result * num)) ;;
    %) result=$((result % num)) ;;
    *)
        echo "Invalid operation"
        exit 1
        ;;
    esac
done

# Debug info
if $debug; then
    echo "User: $(whoami)"
    echo "Script: $0"
    echo "Operation: $operation"
    echo "Numbers: ${numbers[*]}"
fi

echo "Result: $result"
