#!/bin/bash
# This script monitors CPU, memory usage, CPU temperature, and top processes by CPU usage with error handling and logging

LOG_FILE="/var/log/cpu_mem_monitor.log"

# Function to log messages
log_message() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Function to get CPU temperature
get_cpu_temperature() {
  temp=$(sensors | awk '/^temp1:/{print $2}')
  if [ $? -ne 0 ]; then
    log_message "Error: Failed to retrieve CPU temperature."
    exit 1
  fi
  echo "$temp"
}

# Function to get top processes by CPU usage
get_top_processes() {
  # Remove the head command to show all processes sorted by CPU usage
  processes=$(ps -r -eo pid,comm,%cpu --sort=-%cpu)
  if [ $? -ne 0 ]; then
    log_message "Error: Failed to retrieve top processes."
    exit 1
  fi
  echo "$processes"
}

while true; do
  # Get the current usage of CPU and memory
  cpuUsage=$(top -bn1 | awk '/Cpu/ { print $2}')
  if [ $? -ne 0 ]; then
    log_message "Error: Failed to retrieve CPU usage."
    exit 1
  fi

  memUsage=$(free -m | awk '/Mem/{print $3}')
  if [ $? -ne 0 ]; then
    log_message "Error: Failed to retrieve memory usage."
    exit 1
  fi

  # Get the CPU temperature
  cpuTemp=$(get_cpu_temperature)

  # Get the top processes by CPU usage
  topProcesses=$(get_top_processes)

  # Print the usage, temperature, and top processes
  echo "CPU Usage: $cpuUsage%"
  echo "Memory Usage: $memUsage MB"
  echo "CPU Temperature: $cpuTemp"
  echo "Top Processes by CPU Usage:"
  echo "$topProcesses"

  # Log the usage, temperature, and top processes
  log_message "CPU Usage: $cpuUsage%"
  log_message "Memory Usage: $memUsage MB"
  log_message "CPU Temperature: $cpuTemp"
  log_message "Top Processes by CPU Usage:"
  log_message "$topProcesses"

  # Sleep for 1 second
  sleep 1
done


#==========================================================#
# if you get error "/monitor.sh: line 8: /var/log/cpu_mem_monitor.log: Permission denied" then run following commands
#sudo touch /var/log/cpu_mem_monitor.log
#sudo chown $USER /var/log/cpu_mem_monitor.log
# This will create the log file and change its ownership to your current user.