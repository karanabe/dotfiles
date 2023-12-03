#!/bin/bash

# Set current dir
CURRENT_DIR=$(pwd)

DOTFILES=`cat $HOME/.local/.dotfiles`

# Update linux
sudo apt update && sudo apt -y upgrade

# Update this repository
cd $DOTFILES
git pull

cd $CURRENT_DIR
echo "[+] Done. Update your computer. Have fun!!"
