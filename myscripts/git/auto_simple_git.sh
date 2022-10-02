#!/bin/bash

LOG=`pwd`/log.txt
OLD_LOG=`pwd`/log_old.txt
mv ${LOG} ${OLD_LOG}

for d in */ ; do
    echo "$d"
    cd "$d"
    if ! [[ $(git status) =~ "working tree clean" ]]; then
        git add . >> ${LOG} 2>&1
        if ! [[ $(git commit -m "auto update") ]]; then
            echo "$d commit failed" >> ${LOG}
            echo "git commit failed, details see log.txt"
        fi

        if ! [[ $(git push) =~ "error" ]]; then
            echo "$d push failed" >> ${LOG}
            echo "git push failed, details see log.txt"
        fi
    fi


    # git commit -m "auto update" >> ${LOG} 2>&1
    # git push >> ${LOG} 2>&1

    # if [[ 1 == ${rebase} ]]; then
    #     git pull --rebase
    # fi
    # if [[ 1 == "${push}" ]]; then
    #     git push
    # fi
    echo "$d" done
    cd ..
done
${EDITOR} ${LOG}
