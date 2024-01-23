#!/bin/bash

# Function to generate a random password
generate_password() {
    local length="$1"
    local use_uppercase="$2"
    local use_lowercase="$3"
    local use_numbers="$4"
    local use_special_chars="$5"

    local charset=''

    # Define character sets based on user preferences
    [[ "$use_uppercase" == "y" ]] && charset+='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    [[ "$use_lowercase" == "y" ]] && charset+='abcdefghijklmnopqrstuvwxyz'
    [[ "$use_numbers" == "y" ]] && charset+='0123456789'
    [[ "$use_special_chars" == "y" ]] && charset+='!@#$%^&*()-=_+[]{}|;:,.<>?/'

    # Check if at least one character set is selected
    if [ -z "$charset" ]; then
        echo "Error: Please select at least one character set."
        exit 1
    fi

    # Generate random password
    local password=$(tr -dc "$charset" < /dev/urandom | head -c "$length")
    echo "$password"
}

# Function to get user preferences
get_user_preferences() {
    read -p "Enter the length of the password (default: 12): " length
    read -p "Include uppercase letters? (y/n): " uppercase_choice
    read -p "Include lowercase letters? (y/n): " lowercase_choice
    read -p "Include numbers? (y/n): " numbers_choice
    read -p "Include special characters? (y/n): " special_chars_choice

    # Set default values if user presses Enter without providing input
    length=${length:-12}
    uppercase_choice=${uppercase_choice:-"n"}
    lowercase_choice=${lowercase_choice:-"n"}
    numbers_choice=${numbers_choice:-"n"}
    special_chars_choice=${special_chars_choice:-"n"}
}

# Function to display usage information
display_usage() {
    echo "Usage: $0"
}

# Get user preferences
get_user_preferences

# Generate and display the password
password=$(generate_password "$length" "$uppercase_choice" "$lowercase_choice" "$numbers_choice" "$special_chars_choice")

echo "Generated Password is: $password"

