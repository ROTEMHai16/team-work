#!/bin/bash

list_descending() {
    ls -S
}

count_by_extension() {
    suffix="$1"
    total=0
    ls -l *$suffix | wc -l
    for line in $(ls -l *$suffix | awk '{print $5}'); do
        total=$(( $total + line ))
    done
    echo "Their total size is $total bytes"
}

folder_total_size() {
    du -sh | awk '{print $1}'
}

echo "Listing this contents of this folder in descending order by size:"
# List the folder by sizes
list_descending

# Count by a given extension
echo "Count by the given extension:"
count_by_extension $1

# Show total folder size and do some stuff with it
size=$(folder_total_size)
echo "Total folder size is $size"

if (( folder_total_size > 1000 )); then
    read -p "Wanna delete (r) or compress (c) this folder? to do nothing enter something else: r/c/* " answer
    if [[ $answer == "r" ]]; then
        rm -rf ../.
    elif [[ $answer == "c" ]]; then
        tar -czvf ./*
    fi
fi
