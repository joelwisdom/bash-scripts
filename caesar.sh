#!/bin/bash

# Parse parameters
while [[ $# -gt 0 ]]; do
  case "$1" in
    -s) shift_val="$2"; shift 2 ;;
    -i) input_file="$2"; shift 2 ;;
    -o) output_file="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# Validate input
if [[ -z "$shift_val" || -z "$input_file" || -z "$output_file" ]]; then
  echo "Usage: $0 -s <shift> -i <input file> -o <output file>"
  exit 1
fi

if [[ ! -f "$input_file" ]]; then
  echo "Input file not found!"
  exit 1
fi

# Caesar cipher function
caesar_encrypt() {
  local shift=$1
  local char
  while IFS= read -r -n1 char; do
    if [[ "$char" =~ [A-Za-z] ]]; then
      ascii=$(printf "%d" "'$char")
      if [[ "$char" =~ [A-Z] ]]; then
        base=65
      else
        base=97
      fi
      new_ascii=$(( (ascii - base + shift) % 26 + base ))
      printf "\\$(printf "%03o" "$new_ascii")"
    else
      printf "%s" "$char"
    fi
  done
}

# Encrypt and write to output
caesar_encrypt "$shift_val" < "$input_file" > "$output_file"

echo "Encryption complete. Output written to $output_file"
