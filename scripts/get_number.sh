#!/bin/bash

LOCKFILE=/number/lockfile
NUMBERFILE=/number/current
PREFIX=$(cat /number/prefix)

lockfile -1 -r30 "$LOCKFILE"

oldnum=`cut -d ',' -f2 "$NUMBERFILE"`  
newnum=`expr $oldnum + 1`
sed -i "s/$oldnum\$/$newnum/g" $NUMBERFILE

echo "$PREFIX$oldnum"

rm $LOCKFILE
