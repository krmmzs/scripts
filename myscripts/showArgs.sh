#!/bin/bash

for i in $(seq 1 $#)
do
    echo "$i": is "$1"
    shift
done
