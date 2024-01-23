#!/bin/bash

# Function to detect the Linux distribution
detect_distribution() {
    if [ -f /etc/centos-release ]; then
        echo "centos"
    elif [ -f /etc/lsb-release ]; then
        echo "ubuntu"
    else
        echo "unsupported"
    fi
}

# Function to display CPU information
function display_cpu_info() {
    sleep 5
    echo "CPU Information:"
    lscpu
    echo ""
    sleep 5
}

# Function to display RAM information
function display_ram_info() {
    sleep 5
    echo "RAM Information:"
    free -h
    echo ""
    sleep 5
}

# Function to display Disk Space information
function display_disk_info() {
    sleep 5
    echo "Disk Space Information:"
    df -h
    echo ""
    sleep 5
}

# Function to display Network information
function display_network_info() {
    sleep 5
    echo "Network Information:"
    ip a
    echo ""
    sleep 5
}

# Function to display System Uptime
function display_uptime() {
    sleep 5
    echo "System Uptime:"
    uptime
    echo ""
    sleep 5
}

# Function to display Logged-In Users and their login times
function display_logged_in_users() {
    sleep 5
    echo "Logged-In Users and Login Times:"
    who -u
    echo ""
    sleep 5
}

# Function to display Load Average
function display_load_average() {
    sleep 5
    echo "Load Average:"
    cat /proc/loadavg
    echo ""
    sleep 5
}

# Function to display Kernel Version
function display_kernel_version() {
    sleep 5
    echo "Kernel Version:"
    uname -r
    echo ""
    sleep 5
}

# Function to display System Information
function display_system_info() {
    sleep 5
    echo "System Information:"
    uname -a
    echo ""
    sleep 5
}

# Function to update the system with confirmation
function update_system_with_confirmation() {
    DISTRIBUTION=$(detect_distribution)
   
    sleep 3
    user=$(whoami)
    echo "Hello $user, Allow me some little time to update every information on the system. Thank you"
    sleep 5
    echo "Updating the system now..."
    sleep 5
    if [ "$DISTRIBUTION" == "centos" ]; then
        sudo yum update -y
        sleep 4
        echo "Update successfully done. Thank you for your patience."
        sleep 3
    elif [ "$DISTRIBUTION" == "ubuntu" ]; then
        sudo apt update && sudo apt upgrade -y
        sleep 4
        echo "Update successfully done. Thank you for your patience."
        sleep 3
    else
        echo "Unsupported distribution: $DISTRIBUTION"
    fi
    echo ""
}

# Function to display the menu
function display_menu() {
    echo "System Information Menu:"
    echo "1. CPU Information"
    echo "2. RAM Information"
    echo "3. Disk Space Information"
    echo "4. Network Information"
    echo "5. System Uptime"
    echo "6. Logged-In Users and Login Times"
    echo "7. Load Average"
    echo "8. Kernel Version"
    echo "9. System Information"
    echo "0. Exit"
}

# Function to handle user choice
function handle_user_choice() {
    read -p "What Information can I help you with ? Enter your choice (0-9): " choice

    case $choice in
        1) display_cpu_info ;;
        2) display_ram_info ;;
        3) display_disk_info ;;
        4) display_network_info ;;
        5) display_uptime ;;
        6) display_logged_in_users ;;
        7) display_load_average ;;
        8) display_kernel_version ;;
        9) display_system_info ;;
        0) echo "Exiting. Goodbye!"; exit ;;
        *) echo "Invalid choice. Please enter a number between 0 and 9." ;;
    esac
}

# Main script execution with user preferences
function check_distribution_with_menu() {
    DISTRIBUTION=$(detect_distribution)

    if [ "$DISTRIBUTION" == "centos" ] || [ "$DISTRIBUTION" == "ubuntu" ]; then
        update_system_with_confirmation

        while true; do
            display_menu
            handle_user_choice
        done
    else
        echo "Unsupported distribution: $DISTRIBUTION"
    fi
}

# Main script execution with menu
check_distribution_with_menu
