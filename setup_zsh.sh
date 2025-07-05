#!/bin/bash
FILE_DIR=$(
	cd $(dirname $BASH_SOURCE)
	pwd
)

# clear files
rm -rf $HOME/.bash_history $HOME/.bash_logout $HOME/.bashrc $HOME/.lesshst $HOME/.profile
rm -rf $HOME/.zshrc $HOME/.zshenv $HOME/.zprofile $HOME/.zshalias $HOME/.gnupg $HOME/.ssh

mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/lang
mkdir -p $HOME/.local/usr
mkdir -p $HOME/.local/etc
mkdir -p $HOME/.local/opt
mkdir -p $HOME/.local/var
mkdir -p $HOME/.local/share
mkdir -p $HOME/.visualarts/.ssh
mkdir -p $HOME/.visualarts/.gnupg

mkdir -p $HOME/project/data
mkdir -p $HOME/project/docs

mkdir -p $HOME/downloads
mkdir -p $HOME/tmp

mkdir -p $HOME/.config

sudo chmod 700 $HOME/project
sudo chmod 700 $HOME/downloads
sudo chmod 700 $HOME/tmp

sudo chmod 700 $HOME/.local
sudo chmod 700 $HOME/.visualarts
sudo chmod 700 $HOME/.visualarts/.ssh
sudo chmod 700 $HOME/.visualarts/.gnupg

## set link to bash files
ln -s $FILE_DIR/.zshrc $HOME/.zshrc
ln -s $FILE_DIR/.zsh_profile $HOME/.zprofile
ln -s $FILE_DIR/.common_alias $HOME/.zshalias
ln -s $FILE_DIR/.common_export $HOME/.zshenv
ln -s $FILE_DIR/.gitconfig $HOME/.gitconfig
ln -s $FILE_DIR/.gitmessage $HOME/.gitmessage
#ln -s $FILE_DIR/.vimrc $HOME/.vimrc
ln -s $FILE_DIR/.tmux.conf $HOME/.tmux.conf
# ln -s $HOME/.local/share/vimplug $HOME/.vim
ln -s $HOME/.visualarts/.gnupg $HOME/.gnupg
ln -s $HOME/.visualarts/.ssh $HOME/.ssh
ln -s $FILE_DIR/tools/nvim $HOME/.config/nvim
