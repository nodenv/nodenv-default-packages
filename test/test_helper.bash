#!/usr/bin/env bash

BATS_TMPDIR="$BATS_TEST_DIRNAME/tmp"
load ../node_modules/bats-assert/load
load ../node_modules/bats-support/load
load ../node_modules/bats-mock/stub

NODENV_TEST_DIR="${BATS_TMPDIR}/nodenv"
mkdir -p "${NODENV_TEST_DIR}"

export NODENV_ROOT="${NODENV_TEST_DIR}"

PATH=/usr/bin:/bin:/usr/sbin:/sbin
PATH="$BATS_TEST_DIRNAME/helpers/bin:$PATH"
PATH="$BATS_TEST_DIRNAME/../bin:$PATH"
PATH="$BATS_MOCK_BINDIR:$PATH"
export PATH

teardown() {
  rm -rf "$NODENV_TEST_DIR"
  rm -rf "$BATS_MOCK_TMPDIR"
}

with_default_packages_file() {
  touch "${NODENV_ROOT}/default-packages"
  cat - >> "${NODENV_ROOT}/default-packages"
}
