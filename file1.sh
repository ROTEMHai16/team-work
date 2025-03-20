#!/bin/bash

#Input file
echo "Please enter the filename"
read filename

# Check if the file exists
if [[ ! -f "$filename" ]]; then 
echo "File does not exist"
exit 1
fi

echo "File exists"


#initiate counter
tot_words=0
tot_lines=0

#get file size
file_size=$(stat --format="%s" "$filename")

#read file line by line
while  read -r line; do
((tot_lines++))
echo "Line $tot_lines: $line "

word_count=$(echo "$line" | wc -w)
((tot_words+=word_count))
done < "$filename"

echo -e "\nTotal words: $tot_words"
echo "Total lines: $tot_lines"
echo "Total file size: $file_size"
