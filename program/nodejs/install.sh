#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# shellcheck source=../../lib/dotfiles.sh
source "$SCRIPT_DIR/../../lib/dotfiles.sh"

dotfiles_require_safe_home
dotfiles_require_commands bash curl

export VOLTA_HOME="$HOME/.local/lang/volta"
TEMPORARY_INSTALLER=$(mktemp)
trap 'rm -f -- "$TEMPORARY_INSTALLER"' EXIT

curl --fail --location --show-error --silent \
  --proto '=https' --proto-redir '=https' --tlsv1.2 \
  https://get.volta.sh \
  --output "$TEMPORARY_INSTALLER"
bash "$TEMPORARY_INSTALLER" --skip-setup
"$VOLTA_HOME/bin/volta" install node
