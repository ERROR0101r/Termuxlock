#!/bin/bash
# Stealth Mode by HIDDEN KING
# Makes Termux invisible to 'ps' commands

mkdir -p ~/.hidden_termux
cat > ~/.hidden_termux/stealth.sh <<'EOL'
#!/bin/bash
# Real commands will use these hidden paths
export REAL_PATH=$PATH
export PATH=~/.hidden_termux:$PATH

# Create fake commands
ln -sf /bin/true ~/.hidden_termux/ps
ln -sf /bin/true ~/.hidden_termux/top
ln -sf /bin/true ~/.hidden_termux/proc

# Execute real shell
exec bash --norc --noprofile
EOL

chmod +x ~/.hidden_termux/stealth.sh
echo "alias stealth='~/.hidden_termux/stealth.sh'" >> ~/.bashrc
echo -e "Stealth mode installed! Type \033[1;31mstealth\033[0m to activate"