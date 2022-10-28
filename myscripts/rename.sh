#!/bin/bash

rename ''s/ /_/g'' '*.mkv'
count=1;
for mkv in $(find . -maxdepth 1 -iname '*.mkv' -print | sort)
do
    # echo "${mkv}"
    new=$count.${mkv##*.}
    echo "${new}"
    echo "Renaming $mkv to $new"
    mv "$mkv" "$new"
    let count++
done
