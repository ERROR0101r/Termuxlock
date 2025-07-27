#!/bin/bash
# Voice Control by HIDDEN KING
# Requires: pkg install termux-api

cat > ~/.termux/voice_commands.sh <<'EOL'
#!/bin/bash
while true; do
    echo "Say a command:"
    cmd=$(termux-speech-to-text)
    echo "You said: $cmd"
    
    case $cmd in
        *update*) pkg update && pkg upgrade ;;
        *clean*) pkg clean ;;
        *python*) python ;;
        *exit*) break ;;
        *) eval "$cmd" ;;
    esac
done
EOL

chmod +x ~/.termux/voice_commands.sh
echo "alias voice='~/.termux/voice_commands.sh'" >> ~/.bashrc
echo -e "Voice control ready! Type \033[1;35mvoice\033[0m to start"