#!/bin/bash
git clone $GIT_FILTER_REPO filters

while [ true ]; do
  sleep 15
  git pull

  for entry in "filters"/*
  do
    source $entry
    ./pdf_filter.sh
  done
done
