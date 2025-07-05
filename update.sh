#!/bin/bash

# Set current dir
CURRENT_DIR=$(pwd)

DOTFILES=`cat $HOME/.local/.dotfiles`

# Update linux
sudo apt update && sudo apt -y upgrade

# Update this repository
cd $DOTFILES
git pull

# Update zsh plugins
cd $HOME/.local/share/zsh-syntax-highlighting
git pull

cd $HOME/.local/share/zsh-autosuggestions
git pull

cd $CURRENT_DIR
echo "[+] Done. Update your computer. Have fun!!"
