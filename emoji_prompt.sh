#!/bin/bash
# Emoji-fied Prompt by HIDDEN KING 🏆
# Changes PS1 with random emoji each command

# Install emoji font first
pkg install -y libiconv && curl -LO https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji.ttf && mv NotoColorEmoji.ttf ~/.termux/font.ttf

# Array of hacker/programmer emojis
EMOJIS=("💻" "🔥" "🐍" "🚀" "⚡" "🔑" "🎮" "📊" "🧠" "👑" "💾" "🖥️" "📟" "🔌" "📡")

# Random emoji function
random_emoji() {
    echo "${EMOJIS[$RANDOM % ${#EMOJIS[@]}]}"
}

# Set PS1 with emoji
export PS1='\[\e[1;32m\]$(random_emoji) \[\e[1;34m\]\w \[\e[1;31m\]➤ \[\e[0m\]'
echo -e "Emoji prompt activated! \nTry running: \n\nls\ncd\npwd"