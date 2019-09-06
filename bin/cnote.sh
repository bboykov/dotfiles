#!/usr/bin/env bash
# Create a note file with timestamp and top heading

filename="$1-$(date +%Y-%m-%d).md"

if [[ ! -f $filename ]]; then

cat << EOF > "$filename"
# $filename
EOF

vim "$filename"

else
  echo "Note exists."
  exit 0
fi

