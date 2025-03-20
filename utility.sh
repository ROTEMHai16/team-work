#!/bin/bash

list_descending() {
    ls -S
}

count_by_extension() {
    suffix="$1"
    ls -l | grep "$suffix" | wc -l
}

folder_total_size() {
    du -s | awk '{print $1}'
}
# List the folder by sizes
list_descending
# Count by a given extension
count_by_extension $1
# Show total folder size and do some stuff with it
size=$(folder_total_size)
echo "Total folder size is $size"
if (( folder_total_size < 1000 )); then
    read -p "Wanna delete (r) or compress (c) this folder? to do nothing enter something else: r/c/* " answer
    if [[ $answer == "r" ]]; then
        rm -rf ../.
    elif [[ $answer == "c" ]]; then
        tar -czvf ./*
    fi
fi
