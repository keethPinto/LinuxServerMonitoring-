# Linux-Server-Monitoring-Script

## Overview
This Bash script continuously monitors CPU usage, memory usage, CPU temperature, and displays the top processes by CPU usage. The script logs system metrics and any encountered errors to a designated log file.

## Features
- Monitors and logs CPU and memory usage.
- Retrieves CPU temperature and logs any errors during this process.
- Lists the top processes by CPU usage.
- Logs data to `/var/log/cpu_mem_monitor.log`.

## Prerequisites
- **sensors**: This script uses the `sensors` command to retrieve CPU temperature. Ensure that `lm-sensors` is installed and configured:
  ```bash
  sudo apt-get install lm-sensors
  sudo sensors-detect
  ```
- **ps** and **top**: These commands are typically available by default on most Unix-like systems.

## Usage
1. **Set up the log file** (if not already present):
   ```bash
   sudo touch /var/log/cpu_mem_monitor.log
   sudo chown $USER /var/log/cpu_mem_monitor.log
   ```

2. **Run the Script**:
   Make the script executable and run it:
   ```bash
   chmod +x cpu_mem_monitor.sh
   ./cpu_mem_monitor.sh
   ```

3. **Output**:
   The script will output CPU usage, memory usage, CPU temperature, and a list of the top processes by CPU usage to the console every second. All data will also be logged to `/var/log/cpu_mem_monitor.log`.

## Error Handling
If the script encounters issues retrieving data (e.g., CPU temperature or top processes), it will log an error message and exit with a status of 1.

## Example Log Output
The log file (`/var/log/cpu_mem_monitor.log`) will contain entries similar to the following:
```
2024-11-04 12:00:00 - CPU Usage: 10%
2024-11-04 12:00:00 - Memory Usage: 500 MB
2024-11-04 12:00:00 - CPU Temperature: +50.0°C
2024-11-04 12:00:00 - Top Processes by CPU Usage:
  PID COMMAND %CPU
   1234 example 25.3
   5678 example 17.5
```

## Troubleshooting
- **Log file permission error**: If you encounter a permission error, ensure you have created the log file and changed ownership with the following commands:
  ```bash
  sudo touch /var/log/cpu_mem_monitor.log
  sudo chown $USER /var/log/cpu_mem_monitor.log
  ```
