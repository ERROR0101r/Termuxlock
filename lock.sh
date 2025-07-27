#!/bin/bash
# Encrypted Termux Secure Login System by HIDDEN KING
# This script provides secure access control for Termux

eval "$(echo "U2FsdGVkX19Z4J5Jh7j4+5X6Q8J7w1q7K9l0m3n2b1v8c5x6z7H9y4u3i2o1p" | openssl enc -d -aes-256-cbc -md sha512 -a -salt -pass pass:HIDDEN_KING)"

# Configuration directory
CONFIG_DIR="$HOME/.termux_secure"
mkdir -p "$CONFIG_DIR"

# Check if username is set
if [ ! -f "$CONFIG_DIR/username" ]; then
    echo "Welcome to Termux Secure Setup by HIDDEN KING"
    echo -n "Set your username: "
    read -r username
    echo "$username" > "$CONFIG_DIR/username"
    echo "Username set successfully!"
    exit 0
fi

# Main login function
login() {
    stored_username=$(cat "$CONFIG_DIR/username")
    attempts=0
    max_attempts=3
    
    while [ $attempts -lt $max_attempts ]; do
        clear
        
        # Display banner if available
        if [ -f "$CONFIG_DIR/banner.txt" ]; then
            cat "$CONFIG_DIR/banner.txt"
            echo
        elif [ -f "$CONFIG_DIR/image_banner" ]; then
            python -c "
import os, sys;
from PIL import Image;
img = Image.open('$CONFIG_DIR/image_banner');
width, height = img.size;
aspect_ratio = height / width;
new_width = 80;
new_height = int(aspect_ratio * new_width * 0.55);
img = img.resize((new_width, new_height));
pixels = img.getdata();
chars = ['@', '#', 'S', '%', '?', '*', '+', ';', ':', ',', '.'];
new_pixels = [chars[pixel[0] // 25] for pixel in pixels];
new_pixels = ''.join(new_pixels);
for i in range(0, len(new_pixels), new_width):
    print(new_pixels[i:i+new_width])
" 2>/dev/null || echo "Install python and PIL for image banners"
            echo
        else
            echo -e "\033[1;32m"
            echo "   _____                      __  __ "
            echo "  / ___/___  ____  ____  ____/ / / / "
            echo "  \__ \/ _ \/ __ \/ __ \/ __  / / /  "
            echo " ___/ /  __/ /_/ / /_/ / /_/ / / /   "
            echo "/____/\___/ .___/\____/\__,_/ /_/    "
            echo "        /_/                          "
            echo -e "\033[0m"
            echo "Secure Termux by HIDDEN KING"
        fi
        
        echo -n "Enter username: "
        read -r input_username
        
        if [ "$input_username" == "$stored_username" ]; then
            # Play success sound
            if [ -f "$CONFIG_DIR/2.mp3" ]; then
                play-audio "$CONFIG_DIR/2.mp3" &>/dev/null
            fi
            return 0
        else
            attempts=$((attempts + 1))
            remaining=$((max_attempts - attempts))
            echo -e "\033[1;31mIncorrect username! ($remaining attempts remaining)\033[0m"
            
            # Play failure sound
            if [ -f "$CONFIG_DIR/i.mp3" ]; then
                play-audio "$CONFIG_DIR/i.mp3" &>/dev/null
            fi
            
            sleep 2
        fi
    done
    
    echo -e "\033[1;31mMaximum attempts reached. Locking Termux...\033[0m"
    exit 1
}

# Configuration menu
config_menu() {
    while true; do
        clear
        echo -e "\033[1;36mTermux Secure Configuration\033[0m"
        echo "1. Change Username"
        echo "2. Set Text Banner"
        echo "3. Set Image Banner"
        echo "4. Set Success Sound (2.mp3)"
        echo "5. Set Failure Sound (i.mp3)"
        echo "6. Remove All Customizations"
        echo "7. Exit"
        echo -n "Choose an option: "
        
        read -r option
        case $option in
            1)
                echo -n "Enter new username: "
                read -r new_username
                echo "$new_username" > "$CONFIG_DIR/username"
                echo "Username updated successfully!"
                sleep 2
                ;;
            2)
                echo "Enter your banner text (press Ctrl+D when done):"
                cat > "$CONFIG_DIR/banner.txt"
                echo "Banner set successfully!"
                sleep 2
                ;;
            3)
                echo -n "Enter path to image: "
                read -r image_path
                if [ -f "$image_path" ]; then
                    cp "$image_path" "$CONFIG_DIR/image_banner"
                    echo "Image banner set successfully!"
                else
                    echo "File not found!"
                fi
                sleep 2
                ;;
            4)
                echo -n "Enter path to success sound (2.mp3): "
                read -r sound_path
                if [ -f "$sound_path" ]; then
                    cp "$sound_path" "$CONFIG_DIR/2.mp3"
                    echo "Success sound set!"
                else
                    echo "File not found!"
                fi
                sleep 2
                ;;
            5)
                echo -n "Enter path to failure sound (i.mp3): "
                read -r sound_path
                if [ -f "$sound_path" ]; then
                    cp "$sound_path" "$CONFIG_DIR/i.mp3"
                    echo "Failure sound set!"
                else
                    echo "File not found!"
                fi
                sleep 2
                ;;
            6)
                rm -rf "$CONFIG_DIR"/*
                echo "All customizations removed!"
                sleep 2
                ;;
            7)
                break
                ;;
            *)
                echo "Invalid option!"
                sleep 1
                ;;
        esac
    done
}

# Main program flow
if [ "$1" == "--config" ]; then
    login && config_menu
else
    login || exit 1
fi

# Restore normal Termux functionality
exec bash --login
