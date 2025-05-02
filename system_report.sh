#!/bin/bash

# Output file
report_file="system_report.txt"

# Collect data
current_time=$(date)
user_name=$(whoami)
hostname=$(hostname)
internal_ip=$(hostname -I | awk '{print $1}')
external_ip=$(curl -s ifconfig.me)
os_name=$(grep '^PRETTY_NAME' /etc/os-release | cut -d= -f2 | tr -d '"')
uptime_info=$(uptime -p)
disk_info=$(df -h / | awk 'NR==2 {print "Used: "$3" / Free: "$4" / Total: "$2}')
ram_info=$(free -h | awk '/Mem:/ {print "Total: "$2" / Free: "$4}')
cpu_cores=$(nproc)
cpu_freq=$(lscpu | awk -F: '/MHz/ {printf "%.2f MHz", $2; exit}')

# Write to file
{
  echo "===== System Report ====="
  echo "Date & Time       : $current_time"
  echo "User              : $user_name"
  echo "Hostname          : $hostname"
  echo "Internal IP       : $internal_ip"
  echo "External IP       : $external_ip"
  echo "OS                : $os_name"
  echo "Uptime            : $uptime_info"
  echo "Disk Usage (/)    : $disk_info"
  echo "RAM Info          : $ram_info"
  echo "CPU Cores         : $cpu_cores"
  echo "CPU Frequency     : $cpu_freq"
} > "$report_file"

echo "Report saved to $report_file"
