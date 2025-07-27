#!/bin/bash
# Quick Commands by HIDDEN KING
# Menu for frequently used commands

show_menu() {
    clear
    echo -e "\033[1;36mQuick Commands Menu\033[0m"
    echo "1. Update system"
    echo "2. Clean package cache"
    echo "3. Install Python dev environment"
    echo "4. Setup SSH"
    echo "5. Backup Termux"
    echo "6. Restore Termux"
    echo "7. Show system info"
    echo "8. Exit"
    echo -n "Choose option: "
}

update_system() {
    pkg update && pkg upgrade -y
    pip install --upgrade pip
}

clean_system() {
    pkg clean
    rm -rf ~/.cache/*
    echo "Cache cleaned!"
}

python_dev() {
    pkg install -y python clang make
    pip install numpy pandas matplotlib flask
    echo "Python dev setup complete!"
}

setup_ssh() {
    pkg install -y openssh
    echo -n "Enter email for SSH key: "
    read email
    ssh-keygen -t ed25519 -C "$email"
    echo "SSH setup complete!"
    echo "Public key:"
    cat ~/.ssh/id_ed25519.pub
}

backup_termux() {
    tar -czvf termux_backup.tar.gz -C /data/data/com.termux/files ./home ./usr
    echo "Backup created: termux_backup.tar.gz"
}

restore_termux() {
    tar -xzvf termux_backup.tar.gz -C /data/data/com.termux/files
    echo "Restore complete! Restart Termux."
}

system_info() {
    echo -e "\033[1;33mSystem Information:\033[0m"
    echo "OS: $(uname -o)"
    echo "Kernel: $(uname -r)"
    echo "Arch: $(uname -m)"
    echo "Termux: $(pkg show termux-tools | grep Version)"
    echo "Storage: $(df -h ~ | awk 'NR==2{print $4}') free"
}

while true; do
    show_menu
    read option
    case $option in
        1) update_system;;
        2) clean_system;;
        3) python_dev;;
        4) setup_ssh;;
        5) backup_termux;;
        6) restore_termux;;
        7) system_info;;
        8) exit;;
        *) echo "Invalid option!";;
    esac
    echo -n "Press Enter to continue..."
    read
done