#!/bin/bash

git clone https://github.com/nodenv/nodenv.git $HOME/.local/lang/nodenv
cd $HOME/.local/lang/nodenv && src/configure && make -C src

export NODENV_ROOT="$HOME/.local/lang/nodenv"
export PATH="$NODENV_ROOT/bin:$PATH"
eval "$(nodenv init -)"

mkdir -p "$(nodenv root)"/plugins
git clone https://github.com/nodenv/node-build.git "$(nodenv root)/plugins/node-build"

echo "[+] Done. Installed nodejs."
