#!/usr/bin/env bash
# Create a note file with timestamp and top heading

set -euo pipefail
IFS=$'\n\t'

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

  read -r -d '' FILE_BODY << EOM || true
# $(date +%a) ${FILENAME%.*} ${FILEROOT}

EOM
else
  FILENAME="${FILEROOT}-$(date +%Y-%m-%d).md"

  read -r -d '' FILE_BODY << EOM || true
# ${FILEROOT}

EOM
fi

if [[ ! -f ${FILENAME} ]]; then

  cat <<EOF >"${FILENAME}"
${FILE_BODY}
EOF

  echo "${FILENAME}" | ${COPY_TO_CLIPBOARD}
  echo "Note ${FILENAME} created and copied to the clipboard."

else
  echo "Note exists."
  exit 0
fi
