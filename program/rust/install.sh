#!/usr/bin/env bash
set -Eeuo pipefail

export CARGO_HOME="$HOME/.local/lang/cargo"
export RUSTUP_HOME="$HOME/.local/lang/rustup"
export PATH="$CARGO_HOME/bin:$PATH"

sudo apt-get update
sudo apt-get install -y \
  curl \
  ca-certificates \
  build-essential \
  musl-tools
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --default-toolchain nightly
rustup target add x86_64-unknown-linux-musl
rustc --version
