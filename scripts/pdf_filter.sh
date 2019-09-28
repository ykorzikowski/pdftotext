#!/bin/bash
# $PDF_DIR
# $FILTER_PATTERN
# $TARGET_DIR
# $TARGET_DIR_PRFIX (end w/o /)

filter() {
  if [[  $1 != *'ocr'* ]]; then
    return 0
  fi

  pdftotext "$1" - | grep -e ${FILTER_PATTERN}

  # pattern not found
  if [ $? -ne 0 ]; then
    return 0
  fi
  mkdir -p ${TARGET_DIR_PRFIX}/${TARGET_DIR}

  mv $1 ${TARGET_DIR_PRFIX}/${TARGET_DIR}
  echo "Moved $1 to ${TARGET_DIR_PRFIX}/${TARGET_DIR}!"
}

find ${PDF_DIR} -iname '*.pdf' -type f -exec bash -c 'filter "$0"' {} \;
