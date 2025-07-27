#!/bin/bash
# Auto-loader for shortcuts by HIDDEN KING

BASHRC="$HOME/.bashrc"
SHORTCUT_FILE="$HOME/.termux/shortcuts/custom_shortcuts"
PACKAGE_SHORTCUTS="$HOME/.termux/shortcuts/package_shortcuts"

# Add source lines to bashrc if not already present
if ! grep -q "source $SHORTCUT_FILE" "$BASHRC"; then
    echo "" >> "$BASHRC"
    echo "# Custom shortcuts by HIDDEN KING" >> "$BASHRC"
    echo "source $SHORTCUT_FILE" >> "$BASHRC"
    echo "source $PACKAGE_SHORTCUTS" >> "$BASHRC"
    echo "Shortcuts will load automatically now!"
else
    echo "Shortcuts are already set to auto-load"
fi

# Create package shortcuts file if it doesn't exist
if [ ! -f "$PACKAGE_SHORTCUTS" ]; then
    curl -o "$PACKAGE_SHORTCUTS" https://raw.githubusercontent.com/hidden-king/termux-custom/main/package_shortcuts.sh
fi

# Make sure both files are executable
chmod +x "$SHORTCUT_FILE" "$PACKAGE_SHORTCUTS"

echo "Restart Termux or run: source $BASHRC"