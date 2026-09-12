#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# shellcheck source=../../lib/dotfiles.sh
source "$SCRIPT_DIR/../../lib/dotfiles.sh"

dotfiles_clone_or_update https://github.com/rbenv/rbenv.git "$HOME/.local/lang/rbenv"
(
  cd -- "$HOME/.local/lang/rbenv"
  src/configure
  make -C src
)

### As an rbenv plugin
mkdir -p -- "$HOME/.local/lang/rbenv/plugins"
dotfiles_clone_or_update \
  https://github.com/rbenv/ruby-build.git \
  "$HOME/.local/lang/rbenv/plugins/ruby-build"

# Its need for 3.2.0 higher
sudo apt-get install -y libyaml-dev
