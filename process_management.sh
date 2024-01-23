#!/bin/bash

# Author: info@ityourway.tech

# Description: Shell script to automate process and daemon management in CentOS and Ubuntu distributions

# Function to display menu
display_menu() {
    echo "System Management Utility"
    echo "1. View all running processes"
    echo "2. View processes sorted by CPU usage"
    echo "3. View processes sorted by memory usage"
    echo "4. Kill a process"
    echo "5. View all running daemons"
    echo "6. Stop a daemon"
    echo "7. Start a daemon"
    echo "8. View all stopped daemons"
    echo "9. Exit"
}

# Function to display all processes
view_all_processes() {
    ps aux
}

# Function to view processes sorted by CPU usage
view_processes_by_cpu() {
    ps aux --sort=-%cpu
}

# Function to view processes sorted by memory usage
view_processes_by_memory() {
    ps aux --sort=-%mem
}

# Function to kill a process
kill_process() {
    read -p "Enter the PID of the process to kill: " pid

    if [[ -z "$pid" || ! "$pid" =~ ^[0-9]+$ ]]; then
        echo "Invalid PID. Please enter a valid numeric PID."
    else
        read -p "Are you sure you want to kill the process with PID $pid? (y/n): " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            kill -9 "$pid"
            echo "Process with PID $pid killed."
        else
            echo "Process not killed."
        fi
    fi
}

# Function to view all running daemons
view_all_daemons() {
    echo "Running Daemons:"
    systemctl list-units --type=service --state=running

    echo "Dead Daemons:"
    systemctl list-units --type=service --state=dead
}

# Function to stop a daemon
stop_daemon() {
    read -p "Enter the name of the daemon to stop: " daemon_name

    if [[ -z "$daemon_name" ]]; then
        echo "Daemon name cannot be empty."
    else
        read -p "Are you sure you want to stop the daemon $daemon_name? (y/n): " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            systemctl stop "$daemon_name"
            echo "Daemon $daemon_name stopped."
        else
            echo "Daemon not stopped."
        fi
    fi
}

# Function to start a daemon
start_daemon() {
    read -p "Enter the name of the daemon to start: " daemon_name

    if [[ -z "$daemon_name" ]]; then
        echo "Daemon name cannot be empty."
    else
        systemctl start "$daemon_name"
        echo "Daemon $daemon_name started."
    fi
}

# Function to view all stopped daemons
view_all_stopped_daemons() {
    echo "Stopped Daemons:"
    systemctl list-units --type=service --state=exited
}

# Main script
while true; do
    display_menu

    read -p "Enter your choice (1-9): " choice

    case $choice in
        1) view_all_processes ;;
        2) view_processes_by_cpu ;;
        3) view_processes_by_memory ;;
        4) kill_process ;;
        5) view_all_daemons ;;
        6) stop_daemon ;;
        7) start_daemon ;;
        8) view_all_stopped_daemons ;;
        9) echo "Exiting. Goodbye!"; exit ;;
        *) echo "Invalid choice. Please enter a number between 1 and 9." ;;
    esac

    read -p "Press Enter to continue..."
    clear
done

