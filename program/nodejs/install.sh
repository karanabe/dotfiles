#!/usr/bin/env bash
set -Eeuo pipefail

export VOLTA_HOME="$HOME/.local/lang/volta"
curl --fail --location --show-error --silent https://get.volta.sh \
  | bash -s -- --skip-setup
"$VOLTA_HOME/bin/volta" install node
