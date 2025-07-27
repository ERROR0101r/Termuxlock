#!/bin/bash
# The Matrix Effect in Termux by HIDDEN KING
# Requires: pkg install cmatrix

# Custom color matrix
cat > ~/.cmatrixrc <<EOL
Configuration for cmatrix
--color=cyan
--speed=5
--lives=20
--matrix=bold
EOL

# Create shortcut
echo "alias matrix='cmatrix -s -C cyan'" >> ~/.bashrc
echo -e "Matrix effect ready! Type \033[1;32mmatrix\033[0m to start"