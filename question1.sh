#!/bin/bash

# Function to print error message and exit
error_exit() {
    echo "$1" >&2
    exit 1
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    error_exit "Usage: $0 <path_to_log_file>"
fi

LOG_FILE=$1

# Check if the log file exists and is readable
if [ ! -f "$LOG_FILE" ] || [ ! -r "$LOG_FILE" ]; then
    error_exit "Error: Log file does not exist or is not readable"
fi

# Total number of requests
total_requests=$(wc -l < "$LOG_FILE")
echo "Total Requests Count: $total_requests"

# Percentage of successful requests (HTTP status codes 200-299)
successful_requests=$(awk '$9 ~ /^2[0-9][0-9]$/' "$LOG_FILE" | wc -l)
successful_percentage=$(echo "scale=2; ($successful_requests / $total_requests) * 100" | bc)
echo "Percentage of Successful Requests: $successful_percentage%"

# Most active user (IP address with the most requests)
most_active_user=$(awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')
echo "Most Active User: $most_active_user"
