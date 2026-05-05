#!/bin/bash

# Simple Calculator in Bash

echo "=== SIMPLE CALCULATOR ==="
echo "Available operations: + - * / ^ (power) sqrt (square root)"
echo "Type 'quit' to exit"
echo ""

while true; do
    read -p "Enter expression: " input
    
    if [[ "$input" == "quit" ]]; then
        echo "Goodbye!"
        break
    fi
    
    # Handle square root
    if [[ "$input" =~ ^sqrt[[:space:]]+(.+) ]]; then
        num="${BASH_REMATCH[1]}"
        result=$(echo "scale=2; sqrt($num)" | bc -l)
        echo "√$num = $result"
        continue
    fi
    
    # Handle power operation
    if [[ "$input" =~ ^(.+)[[:space:]]*\^[[:space:]]*(.+)$ ]]; then
        a="${BASH_REMATCH[1]}"
        b="${BASH_REMATCH[2]}"
        result=$(echo "scale=2; $a ^ $b" | bc -l)
        echo "$a ^ $b = $result"
        continue
    fi
    
    # Regular calculations
    result=$(echo "scale=2; $input" | bc -l 2>/dev/null)
    
    if [[ -n "$result" ]] && [[ "$result" != *"error"* ]]; then
        # Remove trailing zeros
        result=$(echo "$result" | sed 's/\.0*$//; s/\(\.\d*[1-9]\)0*$/\1/')
        echo "= $result"
    else
        echo "Error! Examples: 5+3, 10/4, 2^8, sqrt 25"
    fi
done
