#!/bin/bash
# Termux Customizer by HIDDEN KING
# Provides various customization options

CONFIG_DIR="$HOME/.termux"

show_menu() {
    clear
    echo -e "\033[1;36mTermux Customizer by HIDDEN KING\033[0m"
    echo "1. Change Color Scheme"
    echo "2. Change Font"
    echo "3. Set Custom Welcome Message"
    echo "4. Install Extra Packages"
    echo "5. Backup Configuration"
    echo "6. Restore Configuration"
    echo "7. Advanced Options"
    echo "8. Exit"
    echo -n "Select an option: "
}

color_scheme() {
    echo -e "\033[1;33mAvailable color schemes:\033[0m"
    echo "1. Default"
    echo "2. Solarized Dark"
    echo "3. Dracula"
    echo "4. Gruvbox"
    echo "5. Custom"
    echo -n "Choose scheme: "
    read choice
    
    case $choice in
        1) colorscheme="default";;
        2) colorscheme="solarized-dark";;
        3) colorscheme="dracula";;
        4) colorscheme="gruvbox";;
        5) 
            echo -n "Enter color path or URL: "
            read colorscheme
            ;;
        *) return;;
    esac
    
    wget -O $CONFIG_DIR/colors.properties "https://raw.githubusercontent.com/termux/termux-styling/master/app/src/main/assets/colors/$colorscheme.properties"
    termux-reload-settings
}

change_font() {
    echo -e "\033[1;33mAvailable fonts:\033[0m"
    echo "1. Ubuntu"
    echo "2. Hack"
    echo "3. Fira Code"
    echo "4. Source Code Pro"
    echo "5. Custom"
    echo -n "Choose font: "
    read choice
    
    case $choice in
        1) font="ubuntu";;
        2) font="hack";;
        3) font="fira-code";;
        4) font="source-code-pro";;
        5) 
            echo -n "Enter font path or URL: "
            read font
            ;;
        *) return;;
    esac
    
    wget -O $CONFIG_DIR/font.ttf "https://raw.githubusercontent.com/termux/termux-styling/master/app/src/main/assets/fonts/$font.ttf"
    termux-reload-settings
}

welcome_message() {
    echo -n "Enter your welcome message: "
    read message
    echo "echo \"$message\"" > $CONFIG_DIR/welcome.sh
    chmod +x $CONFIG_DIR/welcome.sh
    echo "source $CONFIG_DIR/welcome.sh" >> $HOME/.bashrc
}

install_packages() {
    echo -e "\033[1;33mPackage Groups:\033[0m"
    echo "1. Development Tools"
    echo "2. Hacking Tools"
    echo "3. Multimedia"
    echo "4. Games"
    echo "5. Custom Selection"
    echo -n "Choose group: "
    read choice
    
    case $choice in
        1) pkg install -y git python nodejs clang make;;
        2) pkg install -y nmap hydra wireshark tsu;;
        3) pkg install -y ffmpeg sox libmad;;
        4) pkg install -y moon-buggy nudoku;;
        5)
            echo -n "Enter packages to install (space separated): "
            read packages
            pkg install -y $packages
            ;;
        *) return;;
    esac
}

while true; do
    show_menu
    read option
    case $option in
        1) color_scheme;;
        2) change_font;;
        3) welcome_message;;
        4) install_packages;;
        5) 
            tar -czvf termux_backup.tar.gz $CONFIG_DIR
            echo "Backup saved as termux_backup.tar.gz"
            ;;
        6)
            tar -xzvf termux_backup.tar.gz -C $HOME
            termux-reload-settings
            ;;
        7) 
            echo "Advanced options:"
            echo "1. Change shell"
            echo "2. Edit bashrc"
            echo "3. Install Oh-My-Bash"
            echo -n "Choose: "
            read adv_opt
            case $adv_opt in
                1) 
                    echo -n "Enter shell (bash/zsh/fish): "
                    read shell
                    pkg install -y $shell
                    chsh -s $shell
                    ;;
                2) nano $HOME/.bashrc;;
                3) bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)";;
            esac
            ;;
        8) exit;;
        *) echo "Invalid option!"; sleep 1;;
    esac
done