#!/usr/bin/env bash
# Create a note file with timestamp and top heading

set -euo pipefail
IFS=$'\n\t'

readonly NOTES="$HOME/drive/notes/$(date +%Y)"

_JOURNAL=0

case "$OSTYPE" in
  linux*)
    COPY_TO_CLIPBOARD='xclip -selection clipboard'
    ;;
  darwin*)
    COPY_TO_CLIPBOARD='pbcopy'
    ;;
esac

POSITIONAL=()
while [[ ${#} -gt 0 ]]
do
  __option="${1:-}"
  case "${__option}" in
    -j|--journal)
      _JOURNAL=1
      ;;
    -*)
      printf "Unexpected option: %s\\n" "${__option}"
      exit 1
      ;;
    *)
      POSITIONAL+=("${__option}")
      ;;
  esac
  shift
done

set -- "${POSITIONAL[@]}"
if [ $# -gt 1 ]; then
  printf "Too many positional parameters"
  exit 1
fi

FILEROOT="${1-note}"

if [[ _JOURNAL -eq 1 ]]; then
  FILENAME="$(date +%d-%m-%Y).md"
  FILE_PATH="${NOTES}/journal/${FILENAME}"

  read -r -d '' FILE_BODY << EOM || true
# $(date +%a) ${FILENAME%.*} ${FILEROOT}

EOM
else
  FILENAME="${FILEROOT}-$(date +%Y-%m-%d).md"
  FILE_PATH="${NOTES}/${FILENAME}"

  read -r -d '' FILE_BODY << EOM || true
# ${FILEROOT}

EOM
fi


if [[ ! -f ${FILE_PATH} ]]; then

  cat <<EOF >"${FILE_PATH}"
${FILE_BODY}
EOF

  echo "${FILE_PATH}" | eval ${COPY_TO_CLIPBOARD}
  echo "Note ${FILENAME} created and path copied to the clipboard."

else
  echo "Note exists."
  exit 0
fi
