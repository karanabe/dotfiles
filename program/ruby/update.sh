#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# shellcheck source=../../lib/dotfiles.sh
source "$SCRIPT_DIR/../../lib/dotfiles.sh"

dotfiles_require_safe_home
dotfiles_require_commands git make

RBENV_ROOT="$HOME/.local/lang/rbenv"
dotfiles_clone_or_update https://github.com/rbenv/rbenv.git "$RBENV_ROOT"
dotfiles_clone_or_update \
  https://github.com/rbenv/ruby-build.git \
  "$RBENV_ROOT/plugins/ruby-build"

if [[ -x "$RBENV_ROOT/src/configure" ]]; then
  (
    cd -- "$RBENV_ROOT"
    src/configure
    make -C src
  )
fi

printf '[dotfiles] rbenv and ruby-build updated.\n'
