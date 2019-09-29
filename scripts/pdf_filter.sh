#!/bin/bash
# $PDF_INPUT_DIR: directory with unsorted pdf files (eg scanner directory)
# $FILTER_PATTERN: regex allowed. pattern for sorting files
# $TARGET_DIR: target directory to sort in pdfs

filter() {
  pdftotext "$1" - | tr -d '\n' | grep -qP "$FILTER_PATTERN"

  # pattern not found
  if [ $? -ne 0 ]; then
    return 0
  fi
  mkdir -p "${TARGET_DIR}"

  mv "$1" "${TARGET_DIR}"
  echo "Moved $1 to ${TARGET_DIR}!"
}

export -f filter

find "$PDF_INPUT_DIR" -iname '*.pdf' -type f -exec bash -c 'filter "$0"' {} \;
