#!/usr/bin/env bash
set -Eeuo pipefail

HOST_UID=$(id -u)
HOST_GID=$(id -g)
readonly IMAGE_NAME=kernelbuild:latest
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

docker build \
  --build-arg "HOST_UID=$HOST_UID" \
  --build-arg "HOST_GID=$HOST_GID" \
  --tag "$IMAGE_NAME" \
  "$SCRIPT_DIR"
