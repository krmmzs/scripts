#!/bin/bash

file=./output.mkv
dir=./screenshots

ffmpeg -i ${file} -f image2 -vf fps=fps=10 ${dir}/out%d.png
