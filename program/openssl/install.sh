#!/bin/bash

export OPENSSL_VERSION=3.3.0

if [ "$UID" -ne 0 ]; then
  echo "[FAIL] Please run as root"
  exit 1
fi

echo "[PASS] Root check"

mkdir -p /usr/local/musl/include
cd /tmp
curl -fLO "https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz"
tar xvzf "openssl-$OPENSSL_VERSION.tar.gz" && cd "openssl-$OPENSSL_VERSION"
./config -fPIC no-shared no-async --prefix=/usr/local/musl --openssldir=/usr/local/musl/ssl
make -j$(nproc)
make install
rm -r /tmp/openssl-$OPENSSL_VERSION

echo "[PASS] Install complete"

