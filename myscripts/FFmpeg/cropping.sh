#!/bin/bash

# Prompt the user for the input file
read -p "Enter the path to the input MKV file: " input_file

# Prompt the user for the output file
read -p "Enter the path to the output MKV file: " output_file

# Prompt the user for the start time
read -p "Enter the start time" start
#
# Prompt the user for the start time
read -p "Enter the duration" time

# Use FFmpeg to crop the video
ffmpeg -i ${input_file} -ss ${start} -t ${time} -loglevel error -c:v copy -avoid_negative_ts 1 ${output_file}

# Print a message to indicate that the script has completed
echo "Video crop complete!"
