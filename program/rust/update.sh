#!/usr/bin/env bash
set -Eeuo pipefail

if ! command -v rustup >/dev/null 2>&1; then
  printf 'rustup is not installed; run program/rust/install.sh first.\n' >&2
  exit 1
fi

rustup self update
rustup update
