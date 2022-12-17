#!/bin/bash

LOG=../gs.log
for d in */ ; do
    cd "$d" || exit
    if ! [[ $(git status) =~ "working tree clean" ]]; then
        echo "$d" >> "$LOG"
        git status >> "$LOG"
    fi
    cd ..
done
