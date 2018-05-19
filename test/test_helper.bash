#!/usr/bin/env bash

BATS_TMPDIR="$BATS_TEST_DIRNAME/tmp"
load ../node_modules/bats-assert/all
load ../node_modules/bats-mock/stub

NODENV_TEST_DIR="${BATS_TMPDIR}/nodenv"
mkdir -p "${NODENV_TEST_DIR}"

export NODENV_ROOT="${NODENV_TEST_DIR}"

PATH=/usr/bin:/bin:/usr/sbin:/sbin
PATH="$BATS_TEST_DIRNAME/helpers/bin:$PATH"
PATH="$BATS_TEST_DIRNAME/../bin:$PATH"
PATH="$BATS_MOCK_BINDIR:$PATH"
export PATH

npmglobalconfigdir() {
  local version=$1
  echo "$NODENV_ROOT/versions/$version/etc"
}

teardown() {
  rm -rf "$NODENV_TEST_DIR"
  rm -rf "$BATS_MOCK_TMPDIR"
}

# Creates fake version directories
create_versions() {
  for v in $*
  do
    echo "Created version: $v"
    d="$NODENV_TEST_DIR/versions/$v"
    mkdir -p "$d/bin"
    ln -nfs /bin/echo "$d/bin/node"
  done
}

assert_npmrc() {
  local version="$1"
  assert [ -f "$(npmglobalconfigdir $version)/npmrc" ]
}

refute_npmrc() {
  local version="$1"
  refute [ -f "$(npmglobalconfigdir $version)/npmrc" ]
}
