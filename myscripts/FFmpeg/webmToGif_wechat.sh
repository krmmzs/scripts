#!/bin/bash

# webm convert to gif 256

for i in *.webm; do
    ffmpeg -i "$i" -vf scale=256:-1 -pix_fmt rgb24 "${i%.webm}.gif"; 
done
