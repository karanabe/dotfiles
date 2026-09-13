#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
declare -a UPDATE_FAILURES=()

run_update_step() {
  local label=$1
  shift

  printf '\n[dotfiles] Updating %s...\n' "$label"
  if "$@"; then
    printf '[dotfiles] Completed %s.\n' "$label"
  else
    local status=$?
    UPDATE_FAILURES+=("$label (exit $status)")
    printf '[dotfiles] Failed %s with exit code %d; continuing.\n' \
      "$label" "$status" >&2
  fi
}

update_repository() {
  local label=$1
  local directory=$2

  if [[ ! -d "$directory/.git" ]]; then
    printf '[dotfiles] Skipped %s; repository not found: %s\n' \
      "$label" "$directory" >&2
    return
  fi
  git -C "$directory" pull --ff-only
}

update_system_packages() {
  sudo apt-get update
  sudo apt-get upgrade -y
}

main() {
  if (( $# > 1 )) || { (( $# == 1 )) && [[ "$1" != "--system" ]]; }; then
    printf 'usage: %s [--system]\n' "${0##*/}" >&2
    return 2
  fi

  UPDATE_FAILURES=()

  if [[ "${1:-}" == "--system" ]]; then
    run_update_step 'system packages' update_system_packages
  fi

  run_update_step 'dotfiles repository' \
    update_repository dotfiles "$SCRIPT_DIR"
  run_update_step 'Zsh syntax highlighting' \
    update_repository zsh-syntax-highlighting \
    "$HOME/.local/share/zsh-syntax-highlighting"
  run_update_step 'Zsh autosuggestions' \
    update_repository zsh-autosuggestions \
    "$HOME/.local/share/zsh-autosuggestions"

  run_update_step uv "$SCRIPT_DIR/program/python/update.sh"
  run_update_step 'Volta and Node.js LTS' \
    "$SCRIPT_DIR/program/nodejs/update.sh"
  run_update_step Rust "$SCRIPT_DIR/program/rust/update.sh"
  run_update_step 'rbenv and ruby-build' \
    "$SCRIPT_DIR/program/ruby/update.sh"
  run_update_step Go "$SCRIPT_DIR/program/golang/update.sh"
  run_update_step Neovim "$SCRIPT_DIR/program/neovim/update.sh"

  if (( ${#UPDATE_FAILURES[@]} > 0 )); then
    printf '\n[dotfiles] Failed updates:\n' >&2
    printf '  - %s\n' "${UPDATE_FAILURES[@]}" >&2
    return 1
  fi

  printf '\n[dotfiles] All updates completed.\n'
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
