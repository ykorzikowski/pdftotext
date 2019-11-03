#!/bin/bash
echo "starting pdf scanner"

do_pdf_filter() {
   echo "run filter $1"
   source $1
    ./pdf_filter.sh
}

give_number() {
  number=$(/app/get_number.sh)
  basename_=$(basename "$1"|sed 's/\.pdf//g')
  dirname=$(dirname "$1")
  path="${dirname}/../${number}_${basename_}.pdf"

  mv $1 $path
}

export -f do_pdf_filter
export -f give_number

if ! [ -z ${GIVE_NUMBER_DIR+x} ] && ! [ -d /pdf/$GIVE_NUMBER_DIR ]; then
  mkdir /pdf/$GIVE_NUMBER_DIR
fi

while [ true ]; do
  sleep 15

  if ! [ -z ${GIVE_NUMBER_DIR+x} ]; then
    find "/pdf/$GIVE_NUMBER_DIR" -iname '*.pdf' -type f -exec bash -c 'give_number "$0"' {} \;
  fi

  find /filters/ -iname '*.env' -type f -exec bash -c 'do_pdf_filter "$0"' {} \;
done
