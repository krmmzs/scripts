#!/bin/bash

for i in *.webm; do
    ffmpeg -i "$i" -pix_fmt rgb24 "${i%.webm}.gif"; 
done
