#!/bin/bash

rm -rf $HOME/.local/lang/pyenv
git clone https://github.com/pyenv/pyenv.git $HOME/.local/lang/pyenv

# for build python
sudo apt -y install build-essential gdb lcov pkg-config \
    libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
    libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
    lzma lzma-dev tk-dev uuid-dev zlib1g-dev

