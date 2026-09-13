#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# shellcheck source=../../lib/dotfiles.sh
source "$SCRIPT_DIR/../../lib/dotfiles.sh"

install_uv() (
  set -Eeuo pipefail

  dotfiles_require_safe_home
  dotfiles_require_commands curl mktemp sh

  local temporary_dir installer
  temporary_dir=$(mktemp -d)
  trap 'rm -rf -- "$temporary_dir"' EXIT
  installer="$temporary_dir/uv-install.sh"

  curl --fail --location --show-error --silent \
    --proto '=https' --proto-redir '=https' --tlsv1.2 \
    https://astral.sh/uv/install.sh \
    --output "$installer"
  env UV_NO_MODIFY_PATH=1 sh "$installer"
)

update_uv() {
  dotfiles_require_safe_home || return

  if command -v uv >/dev/null 2>&1; then
    if env UV_NO_MODIFY_PATH=1 uv self update; then
      return
    fi
    dotfiles_error \
      'uv self update failed; retrying with the standalone installer.'
  else
    dotfiles_error \
      'uv is not installed; installing it with the standalone installer.'
  fi

  install_uv
}

update_uv
