#!/bin/bash
FILE_DIR=$(
        cd $(dirname $BASH_SOURCE)
        pwd
)

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

