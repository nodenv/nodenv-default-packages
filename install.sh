#!/usr/bin/env sh
# Usage: PREFIX=/usr/local ./install.sh
#
# Installs nodenv-default-packages under $PREFIX.

set -e
set -u

cd "$(dirname "$0")"

if [ -z "${PREFIX}" ]; then
  PREFIX="/usr/local"
fi

ETC_PATH="${PREFIX}/etc/nodenv.d"

mkdir -p "$ETC_PATH"

cp -RPp etc/nodenv.d/* "$ETC_PATH"
