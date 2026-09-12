#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

update_repository() {
  local label=$1
  local directory=$2

  if [[ ! -d "$directory/.git" ]]; then
    printf '[dotfiles] Skipped %s; repository not found: %s\n' "$label" "$directory" >&2
    return
  fi
  printf '[dotfiles] Updating %s...\n' "$label"
  git -C "$directory" pull --ff-only
}

if (( $# > 1 )) || { (( $# == 1 )) && [[ "$1" != "--system" ]]; }; then
  printf 'usage: %s [--system]\n' "${0##*/}" >&2
  exit 2
fi

if [[ "${1:-}" == "--system" ]]; then
  sudo apt-get update
  sudo apt-get upgrade -y
fi

update_repository dotfiles "$SCRIPT_DIR"
update_repository zsh-syntax-highlighting "$HOME/.local/share/zsh-syntax-highlighting"
update_repository zsh-autosuggestions "$HOME/.local/share/zsh-autosuggestions"

printf '[dotfiles] Update complete.\n'
