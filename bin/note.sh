#!/usr/bin/env bash

filename="$1-$(date +%Y-%m-%d).md"

if [[ ! -f $filename ]]; then

touch "$filename"
cat << EOF > "$filename"
# $filename

EOF

vim "$filename"

else
  echo "File exists"
  exit 0
fi

