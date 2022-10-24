#!/bin/bash


for i in *.gif; do
    gifsicle -optimize=3 "$i" -o "${i%.gif}_reduced.gif";
done

