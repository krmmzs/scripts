#!/bin/bash
#!/bin/bash

# Define supported video file formats, you can add or modify according to your needs
VIDEO_FORMATS=("mp4" "mkv" "avi" "mov" "wmv" "flv" "m4v")

# Initialize total duration to 0
total_duration=0

# Loop through files in the current directory
for file in *; do
  # Get file extension
  ext="${file##*.}"

  # Check if file is in a supported video format
  if [[ "${VIDEO_FORMATS[@]}" =~ "$ext" ]]; then
    # Use ffprobe command to get duration of video file
    duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$file" 2>/dev/null)

    # Convert duration to integer in seconds
    duration_int=${duration%.*}

    # Add video file duration to total duration
    total_duration=$((total_duration + duration_int))
    
    # Convert duration to hours, minutes, and seconds
    duration_hours=$((duration_int / 3600))
    duration_minutes=$(( (duration_int % 3600) / 60 ))
    duration_seconds=$((duration_int % 60))
    
    # Print video file name and duration in hours, minutes, and seconds
    echo "Video File: $file Duration: $duration_hours hours $duration_minutes minutes $duration_seconds seconds"
  fi
done

# Convert total duration to hours, minutes, and seconds, and print
total_duration_hours=$((total_duration / 3600))
total_duration_minutes=$(( (total_duration % 3600) / 60 ))
total_duration_seconds=$((total_duration % 60))
echo "Total Duration: $total_duration_hours hours $total_duration_minutes minutes $total_duration_seconds seconds"
