BATS_TMPDIR="$BATS_TEST_DIRNAME/tmp"

load ../node_modules/bats-assert/load
load ../node_modules/bats-support/load
load ../node_modules/bats-mock/stub

setup() {
  # common nodenv setup

  # unset all NODENV_ vars
  for nodenv_var in $(env 2>/dev/null | grep '^NODENV_' | cut -d= -f1); do
    unset "$nodenv_var"
  done
  unset nodenv_var

  # set a restricted PATH (test bin, app bin, and node bin, no homebrew)
  local test_bin="$BATS_TEST_DIRNAME/bin"
  local package_bin="$BATS_TEST_DIRNAME/../bin"
  local node_modules_bin="$BATS_TEST_DIRNAME/../node_modules/.bin"
  local core_path="/usr/bin:/bin:/usr/sbin:/sbin"

  export PATH="$BATS_MOCK_BINDIR:$test_bin:$package_bin:$node_modules_bin:$core_path"
  unset test_bin package_bin node_modules_bin core_path



  # custom setup

  mkdir -p "$BATS_TMPDIR"
  NODENV_ROOT=$(mktemp -d "${BATS_TMPDIR}/nodenv_root.XXX") || exit 1
  export NODENV_ROOT
}

teardown() {
  rm -rf "$BATS_TMPDIR" # same as BATS_MOCK_TMPDIR
}

with_default_packages_file() {
  touch "${NODENV_ROOT}/default-packages"
  cat - >> "${NODENV_ROOT}/default-packages"
}
