#!/bin/bash

# Function to print an error message and exit
error_exit() {
    echo "$1" >&2
    exit 1
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    error_exit "Usage: $0 <directory_path>"
fi

DIR=$1

# Check if the directory exists and is readable
if [ ! -d "$DIR" ] || [ ! -r "$DIR" ]; then
    error_exit "Error: Directory does not exist or is not readable"
fi

# Declare an associative array to hold file type counts
declare -A file_types

# Traverse the directory and count file types
while IFS= read -r -d '' file; do
    # Extract the file extension
    extension="${file##*.}"
    
    # If the file has no extension, use 'no_extension' as the key
    if [ "$file" = "$extension" ]; then
        extension="no_extension"
    fi
    
    # Increment the count for this extension
    ((file_types["$extension"]++))
done < <(find "$DIR" -type f -print0)

# Output the sorted list of file types along with their counts
for extension in "${!file_types[@]}"; do
    echo "$extension: ${file_types[$extension]}"
done | sort
