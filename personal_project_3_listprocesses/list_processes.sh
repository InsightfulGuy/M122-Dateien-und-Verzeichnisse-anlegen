#!/bin/bash

# ls all
list_processes() {
    echo "Listing all running processes:"
    ps -e -o pid,comm
}

# filter by name
filter_processes() {
    read -p "Enter process name to filter: " process_name
    echo "Filtered processes:"
    ps -e -o pid,comm | grep -i $process_name
}

# kill process by process id
kill_process() {
    read -p "Enter PID to kill: " pid
    kill $pid
    if [ $? -eq 0 ]; then
        echo "Process $pid killed successfully."
    else
        echo "Failed to kill process $pid."
    fi
}

while true; do
    echo "Process Manager"
    echo "1. List all processes"
    echo "2. Filter processes by name"
    echo "3. Kill a process by PID"
    echo "4. Exit"
    read -p "Choose an option: " option

    case $option in
        1)
            list_processes
            ;;
        2)
            filter_processes
            ;;
        3)
            kill_process
            ;;
        4)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option, please try again."
            ;;
    esac
done
 
