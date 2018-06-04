#!/usr/bin/env sh
# Usage: PREFIX=/usr/local ./install.sh
#
# Installs nodenv-default-packages under $PREFIX.

set -e
set -u

cd "$(dirname "$0")"

PREFIX="${PREFIX:=/usr/local}"

BIN_PATH="${PREFIX}/bin"
ETC_PATH="${PREFIX}/etc/nodenv.d"

mkdir -p "$BIN_PATH"
mkdir -p "$ETC_PATH"

cp -RPp bin/* "$BIN_PATH"
cp -RPp etc/nodenv.d/* "$ETC_PATH"
