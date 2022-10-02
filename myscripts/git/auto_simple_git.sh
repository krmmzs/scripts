#!/bin/bash

LOG=log.txt

for d in */ ; do
    echo "$d"
    cd "$d"
    if ! [[ $(git status) =~ "working tree clean" ]]; then
        git add . >> ${LOG} 2>&1
        git commit -m "auto update" >> ${LOG} 2>&1
        git push >> ${LOG} 2>&1

        # if [[ 1 == ${rebase} ]]; then
        #     git pull --rebase
        # fi
        # if [[ 1 == "${push}" ]]; then
        #     git push
        # fi
    fi
    echo "$d" done
    cd ..
done
