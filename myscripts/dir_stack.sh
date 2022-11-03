#!/bin/bash

add() {
    echo "$(pwd)" >> $HOME/.dir_stack.log
    echo "save pwd $(pwd)"
}

delete() {
    sed -i '$d' $HOME/.dir_stack.log
    echo "delete pwd $(pwd)"
}

check() {
    cd "$(cat "$HOME/.dir_stack.log" | fzf)"
}
