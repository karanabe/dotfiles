#!/bin/bash

setup-devtools () {
  # Shell
  sudo apt -y install zsh

  # editor
  # sudo apt -y install vim

  # version control
  sudo apt -y install git

  # terminal
  sudo apt -y install tmux
  # Secure Shell
  sudo apt -y install ssh

  # network
  sudo apt -y install wget curl

  # tar
  sudo apt -y install xz-utils

  # secure
  sudo apt -y install gpg

  sudo apt -y install rsync psmisc iproute2 strace lsof
}

## Initial setup not docker
if [ -z "$IS_DOCKER" ]; then
  # Update
  sudo apt -y update && sudo apt -y upgrade

  setup-devtools
fi

# dotfile dir
echo $(cd $(dirname $BASH_SOURCE); pwd) > $HOME/.local/.dotfiles

# nvim
mkdir -p $HOME/.local/opt/nvim
cd $HOME/.local/opt/nvim
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz > nvim-linux64.tar.gz
tar zxf nvim-linux64.tar.gz
ln -s nvim-linux64 currVer

# zsh plugin setup
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.local/share/zsh-syntax-highlighting

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.local/share/zsh-autosuggestions


echo "[+] Complete"

