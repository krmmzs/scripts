#!/bin/bash

filetype=$1

for i in ""*."$filetype"; do
    # ffmpeg -i "$i" '-filter_complex [0:v]fps=15,scale=-1:256,split[a][b];[a]palettegen[p];[b][p]paletteuse' "${i%."$filetype"}.gif"
    ffmpeg -i "$i" -pix_fmt rgb24 "${i%."$filetype"}.gif"
done
