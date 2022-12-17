#!/bin/bash

mkv=./NC_Raws_Bocchi_the_Rock_06_CR_1920x1080_AVC_AAC_MKV_2070.mkv
start="00:16:58"
time="20"
ffmpeg -i ${mkv} -ss ${start} -t ${time} -loglevel error -c:v copy -avoid_negative_ts 1 output.mkv
