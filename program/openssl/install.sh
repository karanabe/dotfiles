#!/usr/bin/env bash
set -Eeuo pipefail

OPENSSL_VERSION=${OPENSSL_VERSION:-3.5.1}

if (( EUID != 0 )); then
  printf '[FAIL] Please run as root.\n' >&2
  exit 1
fi

printf '[PASS] Root check.\n'

TEMPORARY_DIR=$(mktemp -d)
trap 'rm -rf -- "$TEMPORARY_DIR"' EXIT
ARCHIVE="$TEMPORARY_DIR/openssl-$OPENSSL_VERSION.tar.gz"

mkdir -p /usr/local/musl/include
curl --fail --location --show-error \
  "https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz" \
  --output "$ARCHIVE"
tar -xzf "$ARCHIVE" -C "$TEMPORARY_DIR"
cd -- "$TEMPORARY_DIR/openssl-$OPENSSL_VERSION"
./config -fPIC no-shared no-async --prefix=/usr/local/musl --openssldir=/usr/local/musl/ssl
make -j"$(nproc)"
make install

printf '[PASS] Install complete.\n'
