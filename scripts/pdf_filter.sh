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

  basename_=$(basename "$1"|sed 's/\.pdf//g')
  dirname=$(dirname "$1")

  number=$(/app/get_number.sh)
  path="${TARGET_DIR}/${number}_${basename_}.pdf"

  # cp to datev dir
  if [ -v DATEV_DIR ]; then
    datev_path="${DATEV_DIR}/${number}_${basename_}.pdf"
    echo "Copy $1 to $datev_path"
    cp "$1" "$datev_path"
  fi

  # cp to datev dir
  if [ -v DATEV_DIR ]; then
    echo "Copy $1 to $DATEV_DIR"
    cp "$1" "$DATEV_DIR"
  fi

  mv "$1" "$path"
  echo "Moved $1 to $path!"
}

export -f filter

find "$PDF_INPUT_DIR" -iname '*.pdf' -type f -exec bash -c 'filter "$0"' {} \;
