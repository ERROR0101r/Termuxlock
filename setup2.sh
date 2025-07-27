#!/bin/bash
# Termux Customization Setup 2.0 by HIDDEN KING
# Sets permissions for all customization scripts
# Note: Scripts won't run automatically - user must execute them manually

echo -e "\033[1;35m"
echo "   _____ _____ __  __ ______ _   _ _______ "
echo "  / ____|_   _|  \/  |  ____| \ | |__   __|"
echo " | (___   | | | \  / | |__  |  \| |  | |   "
echo "  \___ \  | | | |\/| |  __| | . █ |  | |   "
echo "  ____) |_| |_| |  | | |____| |\  |  | |   "
echo " |_____/|_____|_|  |_|______|_| \_|  |_|   "
echo -e "\033[0m"
echo "Customization Setup - Manual Execution Mode"

# List of all script files
SCRIPTS=(
    "add_to_bashrc.sh"
    "customization.sh"
    "voice_commands.sh"
    "themes.sh"
    "stealth_mod.sh"
    "shortcut.sh"
    "quick_commands.sh"
    "package_shortcut.sh"
    "matrix_effect.sh"
    "emoji_prompt.sh"
)

# Set executable permissions
for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        chmod +x "$script"
        echo -e "\033[1;32m[+]\033[0m Permissions set for $script"
    else
        echo -e "\033[1;31m[!]\033[0m $script not found in current directory"
    fi
done

# Create manual execution instructions
echo -e "\n\033[1;33mSETUP COMPLETE\033[0m"
echo "All scripts are now executable but WON'T RUN AUTOMATICALLY"
echo -e "\n\033[1;36mMANUAL EXECUTION INSTRUCTIONS:\033[0m"
echo "1. To use any script, run it directly with:"
echo "   ./filename.sh"
echo -e "\n2. Recommended execution order:"
echo "   1. ./add_to_bashrc.sh"
echo "   2. ./package_shortcut.sh"
echo "   3. ./customization.sh"
echo "   4. ./themes.sh"
echo "   5. Others as needed"
echo -e "\n3. For security review any script before running:"
echo "   cat filename.sh"

# Security reminder
echo -e "\n\033[1;35mSECURITY NOTE:\033[0m"
echo "These scripts will NOT:"
echo "- Auto-run on terminal start"
echo "- Modify your system without confirmation"
echo "- Install packages without your permission"
echo -e "\nDeveloper: \033[1;33mHIDDEN KING\033[0m"
echo "All scripts require manual execution"
