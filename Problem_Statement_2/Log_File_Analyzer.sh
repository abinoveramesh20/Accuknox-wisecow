#!/bin/bash

# Specify the path to the Apache access log
log_file="/var/log/apache2/access.log"

# Check if the log file exists
if [ ! -f "$log_file" ]; then
  echo "Error: Log file not found."
  exit 1
fi

# Function to print the top N entries
print_top() {
  echo "$1" | sort -rn | head -n 10
}

# Analyze the log file
echo "### Log Analysis Report ###"

# Count the total number of requests
total_requests=$(awk '{print $1}' "$log_file" | wc -l)
echo "Total Requests: $total_requests"

# Count the number
num_404_errors=$(awk '$9 == 404 {print}' "$log_file" | wc -l)
echo "404 Errors: $num_404_errors"

# Display the most requested pages
echo "Top 10 Requested Pages:"
awk '{print $7}' "$log_file" | sort | uniq -c | print_top

# Display the IP addresses with the most requests
echo "Top 10 Requested IP Addresses:"
awk '{print $1}' "$log_file" | sort | uniq -c | print_top

echo "### End of Report ###"
