#!/usr/bin/env bash
set -Eeuo pipefail

git -C "$HOME/.local/lang/rbenv" pull --ff-only
git -C "$HOME/.local/lang/rbenv/plugins/ruby-build" pull --ff-only
printf '[dotfiles] rbenv updated.\n'
