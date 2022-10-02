#!/bin/bash

for d in */ ; do
    echo "$d"
    cd "$d"
    if ! [[ $(git status) =~ "working tree clean" ]]; then
        git add .
        log=$(git commit -m "auto update")
        if [[${log} =~ "error"] || [${log} =~ warning]]; then
            echo ${log} > log.txt
        fi
        git push

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
