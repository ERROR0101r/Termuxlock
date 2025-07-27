#!/bin/bash
# Termux Theme Engine by HIDDEN KING
# Advanced theme management system

THEME_DIR="$HOME/.termux/themes"
mkdir -p "$THEME_DIR"

install_themes() {
    echo "Downloading theme collection..."
    git clone https://github.com/adi1090x/termux-style "$THEME_DIR"
    chmod +x "$THEME_DIR/install"
    ln -s "$THEME_DIR/install" /data/data/com.termux/files/usr/bin/termux-theme
    echo "Use 'termux-theme' to select themes"
}

preview_theme() {
    themes=($(ls "$THEME_DIR/themes" | sed 's/.properties//g'))
    PS3="Select theme to preview: "
    select theme in "${themes[@]}"; do
        if [ -n "$theme" ]; then
            "$THEME_DIR/preview" "$theme"
            break
        fi
    done
}

create_theme() {
    echo -n "Enter theme name: "
    read theme_name
    echo "Creating new theme..."
    cp "$THEME_DIR/themes/default.properties" "$THEME_DIR/themes/$theme_name.properties"
    nano "$THEME_DIR/themes/$theme_name.properties"
    echo "Theme created!"
}

case "$1" in
    install)
        install_themes
        ;;
    preview)
        preview_theme
        ;;
    create)
        create_theme
        ;;
    *)
        echo "Termux Theme Engine by HIDDEN KING"
        echo "Usage: $0 [install|preview|create]"
        ;;
esac