#!/bin/bash

PASSWORD_FILE="passwords.txt"
LOG_FILE="log.txt"

# Function to generate a random password
generate_password() {
    length=12
    password=$(openssl rand -base64 16 | cut -c1-$length)
    echo "Generated Password: $password"
}

# Function to save password
save_password() {
    echo "Enter service name (e.g., Gmail, Facebook): "
    read service
    echo "Enter username/email: "
    read username
    password=$(generate_password)
    echo "$service | $username | $password" >> $PASSWORD_FILE
    echo "$(date): Password saved for $service" >> $LOG_FILE
    echo "Password saved successfully!"
}

# Function to retrieve password
retrieve_password() {
    echo "Enter service name to retrieve password: "
    read service
    grep -i "$service" $PASSWORD_FILE || echo "No password found for $service."
}

# Function to show menu
show_menu() {
    while true; do
        echo "----------------------------"
        echo "🔐 Auto Password Manager"
        echo "1️⃣ Generate Password"
        echo "2️⃣ Save Password"
        echo "3️⃣ Retrieve Password"
        echo "4️⃣ Exit"
        echo "----------------------------"
        read -p "Choose an option: " option
        case $option in
            1) generate_password ;;
            2) save_password ;;
            3) retrieve_password ;;
            4) exit 0 ;;
            *) echo "Invalid option! Please choose again." ;;
        esac
    done
}

# Run the program
show_menu
