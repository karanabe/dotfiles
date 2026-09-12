#!/usr/bin/env bash
set -Eeuo pipefail

curl -LsSf https://astral.sh/uv/install.sh \
  | env UV_NO_MODIFY_PATH=1 sh
mkdir -p -- "$HOME/.local/lang/uv/tools"

# for build python
sudo apt-get update
sudo apt-get install -y build-essential gdb lcov pkg-config \
    libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
    libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
  lzma lzma-dev tk-dev uuid-dev zlib1g-dev
