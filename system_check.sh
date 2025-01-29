#!/bin/bash

echo "Checking hardware configuration..." >> ./hw_info.log

# Display system name and version
echo -e "Raspberry Pi 4 (Ubuntu Server) - Version: $(uname -r)\n" >> ./hw_info.log
echo -e "Kernel version: $(uname -v)\n" >> ./hw_info.log

# checking system information
echo "\033System Information:\033" >> ./hw_info.log
uname -a >> ./hw_info.log

# checking CPU
echo "\033CPU Information:\033" >> ./hw_info.log
sudo lscpu >> ./hw_info.log

# checking memory Usage
echo "\033Memory Usage:\033" >> ./hw_info.log
free -lm >> ./hw_info.log

# Add network interface details with IP address, netmask, and broadcast
echo "\033Network Information:\033" >> ./hw_info.log
ifconfig | awk '
/^[a-zA-Z0-9]+: / { iface=$1 }
/inet / { print "Interface: " iface ", IP: " $2 ", Netmask: " $4 ", Broadcast: " $6 }
' >> ./hw_info.log

echo "Hardware check completed. Output saved to hw_info.log."
