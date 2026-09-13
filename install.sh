#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# shellcheck source=lib/dotfiles.sh
source "$SCRIPT_DIR/lib/dotfiles.sh"

install_system_packages() {
  sudo apt-get update
  sudo apt-get install -y \
    ca-certificates \
    curl \
    git \
    gnupg \
    iproute2 \
    jq \
    lsof \
    psmisc \
    rsync \
    ssh \
    strace \
    tmux \
    wget \
    xz-utils \
    zsh
}

dotfiles_prepare_home

if [[ -z "${IS_DOCKER:-}" ]]; then
  install_system_packages
fi

"$SCRIPT_DIR/program/neovim/install.sh"
dotfiles_clone_or_update \
  https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$HOME/.local/share/zsh-syntax-highlighting"
dotfiles_clone_or_update \
  https://github.com/zsh-users/zsh-autosuggestions.git \
  "$HOME/.local/share/zsh-autosuggestions"
dotfiles_record_repo "$SCRIPT_DIR"

printf '[dotfiles] Installation complete.\n'
