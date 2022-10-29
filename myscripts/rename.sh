#!/bin/bash

filetype="mkv"

rename 's/ /_/g' *.$filetype
count=1;
for file in $(find . -maxdepth 1 -iname '*.'$filetype -print | sort)
do
    # echo "${mkv}"
    new=$count.${file##*.}
    echo "${new}"
    echo "Renaming $file to $new"
    mv "$file" "$new"
    let count++
done
