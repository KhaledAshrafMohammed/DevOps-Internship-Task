#!/bin/bash

# Check if I gave a word and a file
if [ $# -lt 2 ]; then
    echo "Error: I need a word and a file. Like this: ./mygrep.sh word file.txt"
    exit 1
fi

# To know if I should show line numbers or not
show_numbers="no"
# To know if I should show lines that don’t have the word
invert="no"

# Check if first thing is an option like -n or -v
if [[ "$1" == -* ]]; then
    # Look at each letter in the option
    for ((i=1; i<${#1}; i++)); do
        letter="${1:$i:1}"
        if [ "$letter" = "n" ]; then
            show_numbers="yes"
        fi
        if [ "$letter" = "v" ]; then
            invert="yes"
        fi
    done
    shift  # Remove the option so I can get the word and file
fi

# Check again if I have a word and a file after removing options
if [ $# -lt 2 ]; then
    echo "Error: I need a word and a file. Like this: ./mygrep.sh word file.txt"
    exit 1
fi

# Get the word and file
word="$1"
file="$2"

# Check if the file is there
if [ ! -f "$file" ]; then
    echo "Error: I can’t find the file '$file'"
    exit 1
fi

# Start counting lines
line_num=0

# Read the file line by line
while read -r line; do
    line_num=$((line_num + 1))
    
    # Check if the word is in the line (big or small letters don’t matter)
    if echo "$line" | grep -qi "$word"; then
        # If I used -v, skip this line
        if [ "$invert" = "yes" ]; then
            continue
        fi
        # If I used -n, show the line number
        if [ "$show_numbers" = "yes" ]; then
            echo "$line_num:$line"
        else
            echo "$line"
        fi
    else
        # If I used -v, show this line because it doesn’t have the word
        if [ "$invert" = "yes" ]; then
            if [ "$show_numbers" = "yes" ]; then
                echo "$line_num:$line"
            else
                echo "$line"
            fi
        fi
    fi
done < "$file"
