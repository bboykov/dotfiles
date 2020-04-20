#!/usr/bin/env bash
# Create a note file with timestamp and top heading

set -euo pipefail
IFS=$'\n\t'

FILEROOT="$1"
FILENAME="${FILEROOT}-$(date +%Y-%m-%d).md"

case "$OSTYPE" in
  linux*)
    COPY_TO_CLIPBOARD='xclip -selection clipboard'
    ;;
  darwin*)
    COPY_TO_CLIPBOARD='pbcopy'
    ;;
esac

if [[ ! -f ${FILENAME} ]]; then

  cat <<EOF >"${FILENAME}"
# ${FILEROOT}
EOF

  echo "${FILENAME}" | ${COPY_TO_CLIPBOARD}
  echo "Note ${FILENAME} created and copied to the clipboard."

else
  echo "Note exists."
  exit 0
fi
