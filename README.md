#!/bin/bash

# פונקציה: קריאת קובץ שורה אחר שורה
read_file_line_by_line() {
  local file="$1"
  if [[ ! -f "$file" ]]; then
    echo "שגיאה: הקובץ '$file' לא קיים."
    return 1
  fi

  local line_num=1
  while IFS= read -r line; do
    echo "שורה $line_num: $line"
    ((line_num++))
  done < "$file"
}

# פונקציה: ספירת מילים, שורות וגודל קובץ
get_file_stats() {
  local file="$1"
  if [[ ! -f "$file" ]]; then
    echo "שגיאה: הקובץ '$file' לא קיים."
    return 1
  fi

  local word_count=$(wc -w < "$file")
  local line_count=$(wc -l < "$file")
  local file_size=$(stat -c %s "$file")
  echo "מספר מילים: $word_count"
  echo "מספר שורות: $line_count"
  echo "גודל קובץ: $file_size בייטים"
}

# פונקציה: חיפוש טקסט בקובץ
search_in_file() {
  local file="$1"
  local search_term="$2"
  if [[ ! -f "$file" ]]; then
    echo "שגיאה: הקובץ '$file' לא קיים."
    return 1
  fi

  if [[ -z "$search_term" ]]; then
    read_file_line_by_line "$file"
    return 0
  fi

  local word_count=0
  local line_num=1
  while IFS= read -r line; do
    local words=($line)
    for word in "${words[@]}"; do
      ((word_count++))
      if [[ "$word" == "$search_term" ]]; then
        echo "שורה $line_num: $line"
        echo "נמצא: (true, מילה מספר $word_count)"
        return 0
      fi
    done
    ((line_num++))
  done < "$file"
  echo "המונח '$search_term' לא נמצא בקובץ."
}
