#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# shellcheck source=lib/dotfiles.sh
source "$SCRIPT_DIR/lib/dotfiles.sh"

dotfiles_prepare_home
dotfiles_zsh_paths dotfiles_link_paths "$SCRIPT_DIR"
dotfiles_record_repo "$SCRIPT_DIR"
