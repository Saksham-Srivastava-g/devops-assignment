#!/bin/bash

system_health_check(){
    if [ ! -f system_report.txt ]; then
        touch system_report.txt
    fi

    echo "System Report" > system_report.txt

    echo -e "\nDisk usage:\n" >> system_report.txt
    df -h >> system_report.txt

    echo -e "\nCPU Report:\n" >> system_report.txt
    lscpu >> system_report.txt

    echo -e "\nMemory usage:\n" >> system_report.txt
    free -h >> system_report.txt

    echo -e "\nReport saved to system_report.txt"
    echo -e "\nFirst 10 lines of report:"
    head -n 10 system_report.txt
}

active_process(){
    local name=$1

    if [ ! -f process_report.txt ]; then
        touch process_report.txt
    fi

    echo -e "\nListing all the processes:\n"
    ps aux | tee -a process_report.txt

    if [ -z "$name" ]; then
        echo "No input given for filtering."
    else
        if [ ! -f filtered_report.txt ]; then
            touch filtered_report.txt
        fi
        grep -i "$name" process_report.txt > filtered_report.txt
        echo -e "\nFiltered processes containing '$name':"
        cat filtered_report.txt
    fi
}

user_function(){
    read -p "Enter username to add: " username

    if [[ -z "$username" ]]; then
        echo "$0: username cannot be empty"
        return 1
    fi

    if getent passwd "$username" >/dev/null; then
        echo "$0: user with this name already exists"
        return 1
    fi

    read -p "Enter group name: " group_name

    if [[ -z "$group_name" ]]; then
        echo "$0: group name cannot be empty"
        return 1
    fi

    if ! getent group "$group_name" >/dev/null; then
        sudo groupadd "$group_name" 2>/dev/null
    fi

    local pass="123456Pass"
    sudo useradd -m -G "$group_name" "$username"
    echo "$username:$pass" | sudo chpasswd

    echo "User created successfully with password: $pass"

    if [ ! -f testFile.txt ]; then
        touch testFile.txt
    fi

    sudo chown "$username:$group_name" testFile.txt
    echo "File's ownership changed successfully"
}

fileOrganiser(){
    read -p "Enter the Directory path: " dir_path
    if [ ! -d "$dir_path" ]; then
        echo "Error: Directory '$dir_path' not found."
        return 1
    fi

    echo "Creating subdirectories..."
    mkdir -p "$dir_path/images" "$dir_path/docs" "$dir_path/scripts"

    echo "Moving image files (.jpg, .png)..."
    mv "$dir_path"/*.jpg "$dir_path"/*.png "$dir_path/images/" 2>/dev/null

    echo "Moving document files (.txt, .md)..."
    mv "$dir_path"/*.txt "$dir_path"/*.md "$dir_path/docs/" 2>/dev/null

    echo "Moving script files (.sh)..."
    mv "$dir_path"/*.sh "$dir_path/scripts/" 2>/dev/null

    echo "New directory structure:"
    if command -v tree >/dev/null 2>&1; then
        tree "$dir_path"
    else
        ls -R "$dir_path"
    fi
}

network(){
    output_file="network_report.txt"

    if [ ! -f "$output_file" ]; then
        touch "$output_file"
    fi

    echo -e "Running ping test...\n" | tee -a "$output_file"
    ping -c 3 google.com >> "$output_file" 2>&1

    if [ $? -eq 0 ]; then
        echo "Ping to google.com was successful."
        echo "Status: Success" >> "$output_file"
    else
        echo "Ping to google.com failed."
        echo "Status: Failure" >> "$output_file"
    fi

    echo -e "\nRunning dig google.com for resolving DNS...\n" | tee -a "$output_file"
    if command -v dig >/dev/null 2>&1; then
        dig google.com 2>&1 | tee -a "$output_file"
    else
        echo "dig command not found, skipping DNS resolution." | tee -a "$output_file"
    fi

    echo -e "\nHTTP HEADERS (curl -I https://example.com)\n" >> "$output_file"
    curl -I https://example.com >> "$output_file" 2>&1
}

crontab_setup(){
    echo "This script will help you set up a cron job."
    read -p "Enter the absolute path of the script to schedule: " script_path
    read -p "Enter the minute (0-59) for the task to run: " minute
    read -p "Enter the hour (0-23) for the task to run: " hour

    if [ ! -f "$script_path" ]; then
        echo "Error: File not found at '$script_path'."
        return 1
    fi

    if [ ! -x "$script_path" ]; then
        echo "Error: File at '$script_path' is not executable."
        echo "Tip: Run 'chmod +x $script_path' to make it executable."
        return 1
    fi

    cron_command="$minute $hour * * * $script_path"
    (crontab -l 2>/dev/null; echo "$cron_command") | crontab -

    if [ $? -eq 0 ]; then
        echo ""
        echo "Cron job added successfully!"
        echo "The following line was added to your crontab:"
        echo "   $cron_command"
        echo ""
    else
        echo "Error: Failed to add the cron job."
    fi
}

ssh_setup(){
    KEY_PATH="$HOME/.ssh/id_ed25519"
    PUBLIC_KEY_PATH="${KEY_PATH}.pub"

    if [ -f "$KEY_PATH" ]; then
        echo "Notice: An SSH key already exists at $KEY_PATH."
    else
        echo "Generating a new ED25519 SSH key..."
        ssh-keygen -t ed25519 -f "$KEY_PATH" -N "" > /dev/null
        echo "A new SSH key has been generated successfully."
    fi

    echo ""
    echo "Your public SSH key is located at: $PUBLIC_KEY_PATH"
    echo "The contents of your public key are displayed below:"
    echo "------------------------------------------------------------------"
    cat "$PUBLIC_KEY_PATH"
    echo "------------------------------------------------------------------"
    echo ""
    echo "### Instructions for Remote Server Deployment ###"
    echo "To enable passwordless login, the public key must be added to the remote server."
    echo ""
    echo "The standard and recommended method is to use the 'ssh-copy-id' command."
    echo "Execute the following on your local machine:"
    echo ""
    echo "   ssh-copy-id user@remote_host"
    echo ""
    echo "Replace 'user' with your username on the remote host and 'remote_host' with the server's IP address or hostname."
}

# ----------------- Main Menu -----------------

main_menu(){
    while true; do
        echo -e "\n========= System Utility Menu ========="
        echo "1) System Health Check"
        echo "2) Active Processes"
        echo "3) User Management"
        echo "4) File Organiser"
        echo "5) Network Report"
        echo "6) Crontab Setup"
        echo "7) SSH Key Setup"
        echo "8) Exit"
        echo "======================================="
        read -p "Enter your choice [1-8]: " choice

        case $choice in
            1) system_health_check ;;
            2) read -p "Enter process name to filter (leave blank for all): " pname
               active_process "$pname" ;;
            3) user_function ;;
            4) fileOrganiser ;;
            5) network ;;
            6) crontab_setup ;;
            7) ssh_setup ;;
            8) echo -e "\nThank you for using the System Utility Script. Goodbye!"
               exit 0 ;;
            *) echo "Invalid choice. Please try again." ;;
        esac
    done
}

# Start Script
main_menu
