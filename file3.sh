#!/bin/bash

# פונקציה: מחיקת תוכן תיקייה
delete_folder_contents() {
  local file_count=$(ls | wc -l)
  local total_size=$(du -s . | awk '{print $1}')

  read -p "האם אתה בטוח שברצונך למחוק $file_count קבצים (גודל כולל: $total_size בייטים)? (y/n): " confirm
  if [[ "$confirm" == "y" ]]; then
    rm -rf *
    echo "התוכן נמחק."
  else
    echo "המחיקה בוטלה."
  fi
}

# פונקציה: מחיקת קבצים לפי סיומת
delete_files_by_extension() {
  local extension="$1"
  local files=$(ls "*$extension")
  local file_count=$(echo "$files" | wc -w)

  read -p "האם אתה בטוח שברצונך למחוק $file_count קבצים עם סיומת '$extension'? (y/n): " confirm
  if [[ "$confirm" == "y" ]]; then
    rm "*$extension"
    echo "הקבצים נמחקו."
  else
    echo "המחיקה בוטלה."
  fi
}
