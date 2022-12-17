#!/bin/bash

dir=""

# Check if the directory exists
if [ ! -d "$dir" ]; then
  echo "Error: Directory $dir does not exist."
  exit 1
fi

# Check if the user has permission to delete files in the directory
if [ ! -w "$dir" ]; then
  echo "Error: You do not have permission to delete files in $dir."
  exit 1
fi

# Remove all files in the directory
rm "$dir"/*

# Print a message indicating that the files have been removed
echo "All files in $dir have been removed."

# ...
