#!/bin/bash

# Initialize default values
input_file=""
output_file=""
reverse=false
lower=false
upper=false
swap_case=false
substitute=false
sub_word=""
rep_word=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -i) input_file="$2"; shift 2 ;;
    -o) output_file="$2"; shift 2 ;;
    -v) swap_case=true; shift ;;
    -r) reverse=true; shift ;;
    -l) lower=true; shift ;;
    -u) upper=true; shift ;;
    -s) sub_word="$2"; rep_word="$3"; substitute=true; shift 3 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# Validate input and output
if [[ -z "$input_file" || -z "$output_file" ]]; then
  echo "Usage: $0 -i <input file> -o <output file> [options]"
  echo "Options:"
  echo "  -v              Swap case (lower <-> upper)"
  echo "  -s A_WORD B_WORD  Substitute A_WORD with B_WORD (case sensitive)"
  echo "  -r              Reverse lines"
  echo "  -l              Convert to lowercase"
  echo "  -u              Convert to uppercase"
  exit 1
fi

if [[ ! -f "$input_file" ]]; then
  echo "Input file not found!"
  exit 1
fi

# Read file into a variable
text=$(<"$input_file")

# Apply transformations
if $substitute; then
  text="${text//${sub_word}/${rep_word}}"
fi

if $swap_case; then
  text=$(echo "$text" | tr 'A-Za-z' 'a-zA-Z')
fi

if $lower; then
  text=$(echo "$text" | tr '[:upper:]' '[:lower:]')
fi

if $upper; then
  text=$(echo "$text" | tr '[:lower:]' '[:upper:]')
fi

if $reverse; then
  text=$(echo "$text" | tac)
fi

# Write to output file
echo "$text" > "$output_file"
echo "Transformation complete. Output written to $output_file"
