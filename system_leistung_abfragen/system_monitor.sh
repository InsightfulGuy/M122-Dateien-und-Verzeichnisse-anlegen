#!/bin/bash

collect_system_info() {
  echo "-------------------------------------------------------------"
  echo "System Information"
  echo "-------------------------------------------------------------"
  echo "Current System Uptime and Time:"
  printf "\t%s\n" "$(uptime -p) / $(date)"

  echo "Disk Usage:"
  df -h | grep '^/dev/' | awk '{ printf "\t%s: %s used, %s free\n", $1, $3, $4 }'

  echo "Hostname and IP Address:"
  printf "\t%s / %s\n" "$(hostname)" "$(hostname -I | awk '{print $1}')"

  echo "Operating System and Version:"
  printf "\t%s\n" "$(lsb_release -d | awk -F"\t" '{print $2}')"

  echo "CPU Model and Cores:"
  printf "\t%s / %d cores\n" "$(grep 'model name' /proc/cpuinfo | uniq | awk -F": " '{print $2}')" "$(nproc)"

  echo "Total and Used Memory:"
  free -h | awk '/^Mem:/ { printf "\tTotal: %s, Used: %s, Free: %s\n", $2, $3, $4 }'
  echo "-------------------------------------------------------------"
}

if [ "$1" == "-f" ]; then
  LOGFILE="$(date '+%Y-%m')-sys-$(hostname).log"
  collect_system_info >> $LOGFILE
else
  collect_system_info
fi
