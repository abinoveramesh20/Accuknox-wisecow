#!/bin/bash

log_file="/var/log/apache2/access.log"

if [ ! -f "$log_file" ]; then
  echo "Error: Log file not found."
  exit 1
fi

print_top() {
  echo "$1" | sort -rn | head -n 10
}

echo "### Log Analysis Report ###"

total_requests=$(awk '{print $1}' "$log_file" | wc -l)
echo "Total Requests: $total_requests"

num_404_errors=$(awk '$9 == 404 {print}' "$log_file" | wc -l)
echo "404 Errors: $num_404_errors"

echo "Top 10 Requested Pages:"
awk '{print $7}' "$log_file" | sort | uniq -c | print_top

echo "Top 10 Requested IP Addresses:"
awk '{print $1}' "$log_file" | sort | uniq -c | print_top

echo "### End of Report ###"
