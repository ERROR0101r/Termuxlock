#!/bin/bash
# Termux Customization Setup by HIDDEN KING
# Installs all requirements and sets up the environment

echo -e "\033[1;36mTermux Customization Setup by HIDDEN KING\033[0m"
echo "Installing requirements..."

# Update packages
pkg update -y && pkg upgrade -y

# Install basic requirements
pkg install -y git python wget curl openssl-tool

# Install Python packages for image banners
pip install --upgrade pip
pip install pillow

# Install audio tools
pkg install -y sox libmad

# Create the scripts directory
mkdir -p $HOME/.termux/custom
cd $HOME/.termux/custom

# Download the main scripts
wget https://raw.githubusercontent.com/hidden-king/termux-custom/main/secure_termux.sh
wget https://raw.githubusercontent.com/hidden-king/termux-custom/main/termux_customizer.sh
wget https://raw.githubusercontent.com/hidden-king/termux-custom/main/theme_engine.sh

# Make scripts executable
chmod +x *.sh

# Add to bashrc
echo "source $HOME/.termux/custom/secure_termux.sh" >> $HOME/.bashrc

echo -e "\033[1;32mInstallation complete!\033[0m"
echo "Restart Termux or run: source $HOME/.bashrc"
