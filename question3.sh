#!/bin/bash

# Function to print an error message and exit
error_exit() {
    echo "$1" >&2
    exit 1
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    error_exit "Usage: $0 <service_name>"
fi

SERVICE=$1

# Check the status of the service
if systemctl is-active --quiet "$SERVICE"; then
    echo "The service '$SERVICE' is running."
else
    echo "The service '$SERVICE' is not running."
fi
