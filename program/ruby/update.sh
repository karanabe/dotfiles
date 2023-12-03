#!/bin/sh
# Update script for rbenv

# rbenv upgrade
cd $HOME/.local/lang/rbenv
git pull
echo "[+] Done. Update rbenv."
