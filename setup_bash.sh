#!/bin/bash
FILE_DIR=$(cd $(dirname $BASH_SOURCE); pwd)

# clear files
rm -rf $HOME/.bashrc $HOME/.bash_profile $HOME/.zshrc $HOME/.gnupg $HOME/.ssh

# set link to bash files
ln -s $FILE_DIR/.bash_profile $HOME/.bash_profile


mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/lang
mkdir -p $HOME/.local/usr
mkdir -p $HOME/.local/etc
mkdir -p $HOME/.local/opt
mkdir -p $HOME/.local/var
mkdir -p $HOME/.local/share/vimplug
mkdir -p $HOME/.visualarts/.ssh
mkdir -p $HOME/.visualarts/.gnupg

mkdir -p $HOME/project/data
mkdir -p $HOME/project/docs

mkdir -p $HOME/downloads
mkdir -p $HOME/tmp

sudo chmod 700 $HOME/project
sudo chmod 700 $HOME/downloads
sudo chmod 700 $HOME/tmp

sudo chmod 700 $HOME/.local
sudo chmod 700 $HOME/.visualarts
sudo chmod 700 $HOME/.visualarts/.ssh
sudo chmod 700 $HOME/.visualarts/.gnupg

## set link to bash files
ln -s $FILE_DIR/.bashrc $HOME/.bashrc
ln -s $FILE_DIR/.common_alias $HOME/.bash_alias
ln -s $FILE_DIR/.common_export $HOME/.bash_export
ln -s $FILE_DIR/.bash_prompt $HOME/.bash_prompt
ln -s $FILE_DIR/.gitconfig $HOME/.gitconfig
ln -s $FILE_DIR/.gitmessage $HOME/.gitmessage
ln -s $FILE_DIR/.vimrc $HOME/.vimrc
ln -s $FILE_DIR/.inputrc $HOME/.inputrc
ln -s $FILE_DIR/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/.local/share/vimplug $HOME/.vim
ln -s $HOME/.visualarts/.gnupg $HOME/.gnupg
ln -s $HOME/.visualarts/.ssh $HOME/.ssh

