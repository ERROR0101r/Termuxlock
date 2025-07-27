#!/bin/bash
# Termux Shortcut Manager by HIDDEN KING
# Creates custom command aliases and shortcuts

SHORTCUT_DIR="$HOME/.termux/shortcuts"
mkdir -p "$SHORTCUT_DIR"
SHORTCUT_FILE="$SHORTCUT_DIR/custom_shortcuts"

# Load existing shortcuts
if [ -f "$SHORTCUT_FILE" ]; then
    source "$SHORTCUT_FILE"
fi

add_shortcut() {
    echo -e "\033[1;33mCurrent shortcuts:\033[0m"
    grep "alias" "$SHORTCUT_FILE" 2>/dev/null || echo "No shortcuts yet"
    
    echo -n "Enter shortcut name (e.g., 'update'): "
    read shortcut
    echo -n "Enter full command (e.g., 'pkg update && pkg upgrade'): "
    read command
    
    echo "alias $shortcut='$command'" >> "$SHORTCUT_FILE"
    echo "Shortcut added! Restart Termux or run: source $SHORTCUT_FILE"
}

remove_shortcut() {
    echo -e "\033[1;33mCurrent shortcuts:\033[0m"
    nl "$SHORTCUT_FILE" 2>/dev/null || echo "No shortcuts yet"
    
    echo -n "Enter shortcut number to remove: "
    read num
    
    if [ -s "$SHORTCUT_FILE" ]; then
        sed -i "${num}d" "$SHORTCUT_FILE"
        echo "Shortcut removed!"
    else
        echo "No shortcuts to remove"
    fi
}

list_shortcuts() {
    echo -e "\033[1;36mYour Custom Shortcuts:\033[0m"
    grep "alias" "$SHORTCUT_FILE" 2>/dev/null | sed 's/alias //' | sed "s/='/ → /" | sed "s/'$//" || echo "No shortcuts yet"
}

edit_shortcuts() {
    nano "$SHORTCUT_FILE"
    echo "Don't forget to run: source $SHORTCUT_FILE"
}

while true; do
    clear
    echo -e "\033[1;36mTermux Shortcut Manager by HIDDEN KING\033[0m"
    echo "1. Add new shortcut"
    echo "2. Remove shortcut"
    echo "3. List all shortcuts"
    echo "4. Edit shortcuts file"
    echo "5. Exit"
    echo -n "Choose option: "
    
    read choice
    case $choice in
        1) add_shortcut;;
        2) remove_shortcut;;
        3) list_shortcuts;;
        4) edit_shortcuts;;
        5) exit;;
        *) echo "Invalid option!"; sleep 1;;
    esac
    echo -n "Press Enter to continue..."
    read
done