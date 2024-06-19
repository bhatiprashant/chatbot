#!/bin/bash

# Input and output file names
input_file="./documents/tresataSupportPosts"
output_file="./documents/cleanedTresataSupportPosts"

# Function to clean the input file
clean_file() {
    # Remove unwanted characters and normalize spacing
    sed -e 's/\\n/\n/g' \
        -e 's/\\//g' \
        -e 's/\*\*PREREQUISITES:\*\*/PREREQUISITES:/g' \
        -e 's/\*\*STEPS:\*\*/STEPS:/g' \
        -e 's/\*\|\*\*/|/g' \
        -e 's/|false|true|true|4|0.6 Set Up A Namespace On Azure|93//g' \
        -e 's/Screen: 6.0//g' \
        -e 's/|690x359//g' \
        -e 's/upload:\/\/kB0YXVl4JSXjaLZV0zaLEw4v08h.png//g' \
        -e 's/^[ \t]*//g' \
        -e '/^$/d' \
        -e 's/^[0-9]\+\.\s*/&\n/g' \
        -e 's/```\([^`]*\)```/\1/g' \
        "$input_file" > "$output_file"
}

# Main script execution
clean_file
echo "Cleaning complete. The cleaned content is in $output_file."

