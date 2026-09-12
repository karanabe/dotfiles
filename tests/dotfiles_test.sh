#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# shellcheck source=../lib/dotfiles.sh
source "$SCRIPT_DIR/../lib/dotfiles.sh"

TEST_ROOT=$(mktemp -d)
trap 'rm -rf -- "$TEST_ROOT"' EXIT

fail() {
  printf 'not ok - %s\n' "$1" >&2
  exit 1
}

pass() {
  printf 'ok - %s\n' "$1"
}

test_link_is_idempotent() {
  local source_path="$TEST_ROOT/idempotent/source"
  local target_path="$TEST_ROOT/idempotent/target"
  mkdir -p -- "$(dirname -- "$source_path")"
  printf 'source\n' >"$source_path"

  dotfiles_link_paths "$source_path" "$target_path" >/dev/null
  dotfiles_link_paths "$source_path" "$target_path" >/dev/null
  [[ -L "$target_path" && "$target_path" -ef "$source_path" ]] \
    || fail 'managed links are idempotent'
  pass 'managed links are idempotent'
}

test_preflight_prevents_partial_setup() {
  local first_source="$TEST_ROOT/preflight/first-source"
  local second_source="$TEST_ROOT/preflight/second-source"
  local first_target="$TEST_ROOT/preflight/first-target"
  local second_target="$TEST_ROOT/preflight/second-target"
  mkdir -p -- "$(dirname -- "$first_source")"
  printf 'first\n' >"$first_source"
  printf 'second\n' >"$second_source"
  printf 'existing\n' >"$second_target"

  if dotfiles_link_paths \
    "$first_source" "$first_target" \
    "$second_source" "$second_target" >/dev/null 2>&1; then
    fail 'preflight rejects existing targets'
  fi
  [[ ! -e "$first_target" ]] || fail 'preflight prevents partial setup'
  pass 'preflight prevents partial setup'
}

test_foreign_paths_are_preserved() {
  local managed_source="$TEST_ROOT/unlink/managed-source"
  local foreign_source="$TEST_ROOT/unlink/foreign-source"
  local managed_target="$TEST_ROOT/unlink/managed-target"
  local foreign_target="$TEST_ROOT/unlink/foreign-target"
  mkdir -p -- "$(dirname -- "$managed_source")"
  printf 'managed\n' >"$managed_source"
  printf 'foreign\n' >"$foreign_source"
  ln -s -- "$managed_source" "$managed_target"
  ln -s -- "$foreign_source" "$foreign_target"

  if dotfiles_unlink_paths \
    "$managed_source" "$managed_target" \
    "$managed_source" "$foreign_target" >/dev/null 2>&1; then
    fail 'unlink reports foreign paths'
  fi
  [[ ! -e "$managed_target" && ! -L "$managed_target" ]] \
    || fail 'managed link is removed'
  [[ -L "$foreign_target" && "$foreign_target" -ef "$foreign_source" ]] \
    || fail 'foreign link is preserved'
  pass 'unlink removes only managed links'
}

test_unsafe_home_is_rejected() {
  if (HOME=/; dotfiles_require_safe_home >/dev/null 2>&1); then
    fail 'unsafe HOME is rejected'
  fi
  pass 'unsafe HOME is rejected'
}

test_zsh_manifest_round_trip() {
  (
    export HOME="$TEST_ROOT/home"
    dotfiles_prepare_home
    dotfiles_zsh_paths dotfiles_link_paths "$SCRIPT_DIR/.." >/dev/null
    [[ "$HOME/.zshrc" -ef "$SCRIPT_DIR/../.zshrc" ]]
    [[ "$HOME/.config/nvim" -ef "$SCRIPT_DIR/../tools/nvim" ]]
    [[ "$HOME/.ssh" -ef "$HOME/.visualarts/.ssh" ]]
    dotfiles_zsh_paths dotfiles_unlink_paths "$SCRIPT_DIR/.." >/dev/null
    [[ ! -e "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]
    [[ ! -e "$HOME/.ssh" && ! -L "$HOME/.ssh" ]]
  ) || fail 'Zsh manifest links and unlinks as a unit'
  pass 'Zsh manifest links and unlinks as a unit'
}

test_conflict_does_not_record_checkout() {
  local home_directory="$TEST_ROOT/conflicting-home"
  mkdir -p -- "$home_directory"
  printf 'existing configuration\n' >"$home_directory/.zshrc"

  if HOME="$home_directory" bash "$SCRIPT_DIR/../link.sh" >/dev/null 2>&1; then
    fail 'link entry point rejects a conflicting home'
  fi
  [[ ! -e "$home_directory/.local/.dotfiles" ]] \
    || fail 'failed setup does not record the checkout'
  pass 'failed setup does not record the checkout'
}

test_link_is_idempotent
test_preflight_prevents_partial_setup
test_foreign_paths_are_preserved
test_unsafe_home_is_rejected
test_zsh_manifest_round_trip
test_conflict_does_not_record_checkout
