

#!/bin/bash

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

check_cpu_usage() {
    local cpu_usage=$(top -b -n 1 | awk '/^%Cpu/ {print $2}' | cut -d. -f1)
    echo "CPU Usage: $cpu_usage%"
    if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
        echo "ALERT: High CPU usage detected!" >> system_health.log
    fi
}

check_memory_usage() {
    local memory_usage=$(free | awk '/Mem:/ {printf("%.2f", $3/$2 * 100)}')
    echo "Memory Usage: $memory_usage%"
    if [ "$(echo "$memory_usage > $MEMORY_THRESHOLD" | bc -l)" -eq 1 ]; then
        echo "ALERT: High memory usage detected!" >> system_health.log
    fi
}

check_disk_space() {
    local disk_usage=$(df -h | awk '/\/$/ {print $5}' | cut -d% -f1)
    echo "Disk Space Usage: $disk_usage%"
    if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
        echo "ALERT: Low disk space detected!" >> system_health.log
    fi
}

check_running_processes() {
    local process_count=$(ps aux --no-heading | wc -l)
    echo "Running Processes: $process_count"
}
main() {
    echo "System Health Check: $(date)"
    check_cpu_usage
    check_memory_usage
    check_disk_space
    check_running_processes
}
main
