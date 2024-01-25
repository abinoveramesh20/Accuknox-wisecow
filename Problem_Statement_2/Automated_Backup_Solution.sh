#!/bin/bash

# Configuration
source_directory="/path/to/source/directory"  # Change this to the directory you want to backup
remote_server="user@remote-server:/path/to/backup"  # Change this to your remote server details
report_file="/path/to/backup_report.txt"  # Change this to the desired report file path

# Check if the source directory exists
if [ ! -d "$source_directory" ]; then
    echo "Error: Source directory not found at $source_directory"
    exit 1
fi

# Check if the report file is writable
if touch "$report_file"; then
    echo "Backup Report" > "$report_file"
else
    echo "Error: Unable to write to the report file at $report_file"
    exit 1
fi

# Perform backup using rsync
rsync -avz --delete "$source_directory" "$remote_server" >> "$report_file" 2>&1

# Check the exit status of rsync
if [ $? -eq 0 ]; then
    echo "Backup Successful. Report written to: $report_file"
else
    echo "Backup Failed. Report written to: $report_file"
fi

