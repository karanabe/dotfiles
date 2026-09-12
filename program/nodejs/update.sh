#!/usr/bin/env bash
set -Eeuo pipefail

if ! command -v volta >/dev/null 2>&1; then
  printf 'Volta is not installed; run program/nodejs/install.sh first.\n' >&2
  exit 1
fi

volta install node
