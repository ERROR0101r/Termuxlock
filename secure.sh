#!/bin/bash
# Encrypted Termux Secure System by HIDDEN KING
# Provides login security and customization

CONFIG_DIR="$HOME/.termux_secure"
mkdir -p "$CONFIG_DIR"

# First-time setup
if [ ! -f "$CONFIG_DIR/username" ]; then
    echo "Welcome to Termux Secure Setup by HIDDEN KING"
    echo -n "Set your username: "
    read -r username
    echo "$username" > "$CONFIG_DIR/username"
    
    echo -n "Set your password (hidden input): "
    read -s -r password
    echo
    echo "$password" | openssl enc -base64 > "$CONFIG_DIR/password"
    
    echo "Security setup complete!"
    exit 0
fi

login() {
    stored_username=$(cat "$CONFIG_DIR/username")
    stored_password=$(cat "$CONFIG_DIR/password" | openssl enc -d -base64)
    attempts=0
    max_attempts=3
    
    while [ $attempts -lt $max_attempts ]; do
        clear
        
        # Display custom banner
        display_banner
        
        echo -n "Username: "
        read -r input_username
        echo -n "Password: "
        read -s -r input_password
        echo
        
        if [ "$input_username" == "$stored_username" ] && 
           [ "$input_password" == "$stored_password" ]; then
            play_audio "success"
            return 0
        else
            attempts=$((attempts + 1))
            remaining=$((max_attempts - attempts))
            echo -e "\033[1;31mAccess denied! ($remaining attempts remaining)\033[0m"
            play_audio "failure"
            sleep 2
        fi
    done
    
    echo -e "\033[1;31mMaximum attempts reached. Locking Termux...\033[0m"
    exit 1
}

display_banner() {
    if [ -f "$CONFIG_DIR/image_banner" ]; then
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
    elif [ -f "$CONFIG_DIR/banner.txt" ]; then
        cat "$CONFIG_DIR/banner.txt"
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
}

play_audio() {
    type=$1
    if [ -f "$CONFIG_DIR/${type}_sound.mp3" ]; then
        play-audio "$CONFIG_DIR/${type}_sound.mp3" &>/dev/null
    fi
}

if [ "$1" == "--config" ]; then
    login && config_menu
else
    login || exit 1
fi

exec bash --login