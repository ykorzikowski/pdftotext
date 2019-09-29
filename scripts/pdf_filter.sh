#!/bin/bash
# $PDF_INPUT_DIR: directory with unsorted pdf files (eg scanner directory)
# $FILTER_PATTERN: regex allowed. pattern for sorting files
# $TARGET_DIR: target directory to sort in pdfs
export DATE_STR="%y-%m-%d_%H-%M-%S"

filter() {
  pdftotext "$1" - | tr -d '\n' | grep -qP "$FILTER_PATTERN"

  # pattern not found
  if [ $? -ne 0 ]; then
    return 0
  fi
  mkdir -p "${TARGET_DIR}"

  # on file conflict
  if [[ -f ${TARGET_DIR}/$(basename "$1") ]]; then
    date=$(date +$DATE_STR)
    basename_=$(basename $1)
    path="$TARGET_DIR/conflict_${date}_${basename_}"
  else
    path=${TARGET_DIR}
  fi

  mv "$1" "$path"
  echo "Moved $1 to ${TARGET_DIR}!"
}

export -f filter

find "$PDF_INPUT_DIR" -iname '*.pdf' -type f -exec bash -c 'filter "$0"' {} \;
