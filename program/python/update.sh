#!/usr/bin/env bash
set -Eeuo pipefail

if ! command -v uv >/dev/null 2>&1; then
  printf 'uv is not installed; run program/python/install.sh first.\n' >&2
  exit 1
fi

UV_NO_MODIFY_PATH=1 uv self update
