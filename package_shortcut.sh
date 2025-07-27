#!/bin/bash
# Package Shortcuts by HIDDEN KING
# Common package management shortcuts

# System commands
alias update='pkg update && pkg upgrade'
alias install='pkg install'
alias remove='pkg uninstall'
alias search='pkg search'
alias clean='pkg clean'

# Git shortcuts
alias gclone='git clone'
alias gcommit='git commit -m'
alias gpush='git push'
alias gpull='git pull'
alias gstatus='git status'

# Python shortcuts
alias py='python'
alias py3='python3'
alias pipup='pip install --upgrade pip'
alias pylist='pip list'

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias la='ls -a'

# Custom functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xvjf "$1" ;;
            *.tar.gz) tar xvzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xvf "$1" ;;
            *.tbz2) tar xvjf "$1" ;;
            *.tgz) tar xvzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "Unknown archive format" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}