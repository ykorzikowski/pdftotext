#!/bin/bash
# $PDF_INPUT_DIR: directory with unsorted pdf files (eg scanner directory)
# $FILTER_PATTERN: regex allowed. pattern for sorting files
# $TARGET_DIR: target directory to sort in pdfs

filter() {
  if [[  $1 != *'ocr'* ]]; then
    return 0
  fi

  pdftotext "$1" - | grep -e ${FILTER_PATTERN}

  # pattern not found
  if [ $? -ne 0 ]; then
    return 0
  fi
  mkdir -p /pdf/${TARGET_DIR}

  mv $1 /pdf/${TARGET_DIR}
  echo "Moved $1 to ${TARGET_DIR_PRFIX}/${TARGET_DIR}!"
}

find ${PDF_DIR} -iname '*.pdf' -type f -exec bash -c 'filter "$0"' {} \;
