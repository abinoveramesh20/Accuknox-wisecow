#!/bin/bash

# Configuration
source_directory="/home/ubuntu/Accuknox-wisecow"
destination_server="ubuntu@13.127.90.124:home/ubuntu/test"
log_file="/home/ubuntu/backup_log.txt"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$log_file"
}

# Check if the source directory exists
if [ ! -d "$source_directory" ]; then
    log_message "Error: Source directory not found."
    exit 1
fi

# Check if the destination server is reachable
if ! ping -c 1 -W 1 "$(echo "$destination_server" | cut -d'@' -f2 | cut -d':' -f1)" > /dev/null; then
    log_message "Error: Unable to reach the destination server."
    exit 1
fi

# Run rsync to perform the backup
rsync -av --delete "$source_directory" "$destination_server" 2>&1 | tee -a "$log_file"

# Check the exit status of rsync
if [ ${PIPESTATUS[0]} -eq 0 ]; then
    log_message "Backup successful."
    exit 0
else
    log_message "Error: Backup failed. Check the log for details."
    exit 1
fi
