#!/usr/bin/env bash
set -Eeuo pipefail

# Override GO_PACKAGE to install a different official archive.
GO_PACKAGE=${GO_PACKAGE:-go1.22.2.linux-amd64.tar.gz}
TEMPORARY_DIR=$(mktemp -d)
trap 'rm -rf -- "$TEMPORARY_DIR"' EXIT

if [[ -z "${HOME:-}" || "$HOME" == "/" ]]; then
  printf 'HOME must point to a user directory.\n' >&2
  exit 1
fi

# Get golang package
curl --fail --location --show-error --silent \
  "https://dl.google.com/go/$GO_PACKAGE" \
  --output "$TEMPORARY_DIR/$GO_PACKAGE"
tar -C "$TEMPORARY_DIR" -xzf "$TEMPORARY_DIR/$GO_PACKAGE"

INSTALL_ROOT="$HOME/.local/lang"
INSTALL_DIRECTORY="$INSTALL_ROOT/go"
BACKUP_DIRECTORY="$INSTALL_ROOT/.go.previous.$$"
mkdir -p -- "$INSTALL_ROOT"

if [[ -e "$INSTALL_DIRECTORY" || -L "$INSTALL_DIRECTORY" ]]; then
  mv -- "$INSTALL_DIRECTORY" "$BACKUP_DIRECTORY"
fi
if ! mv -- "$TEMPORARY_DIR/go" "$INSTALL_DIRECTORY"; then
  [[ ! -e "$BACKUP_DIRECTORY" && ! -L "$BACKUP_DIRECTORY" ]] \
    || mv -- "$BACKUP_DIRECTORY" "$INSTALL_DIRECTORY"
  exit 1
fi
[[ ! -e "$BACKUP_DIRECTORY" && ! -L "$BACKUP_DIRECTORY" ]] \
  || rm -rf -- "$BACKUP_DIRECTORY"
