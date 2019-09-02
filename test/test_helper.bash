BATS_TMPDIR="$BATS_TEST_DIRNAME/tmp"

load ../node_modules/bats-assert/load
load ../node_modules/bats-support/load
load ../node_modules/bats-mock/stub

setup() {
  # common nodenv setup

  # unset all NODENV_ vars
  local nodenv_var
  for nodenv_var in $(env 2>/dev/null | grep '^NODENV_' | cut -d= -f1); do
    unset "$nodenv_var"
  done

  # unset all XDG_ vars
  local xdg_var
  for xdg_var in $(env 2>/dev/null | grep '^XDG_' | cut -d= -f1); do
    unset "$xdg_var"
  done

  # set a restricted PATH (test bin, app bin, and node bin, no homebrew)
  local test_bin="$BATS_TEST_DIRNAME/bin"
  local package_bin="$BATS_TEST_DIRNAME/../bin"
  local node_modules_bin="$BATS_TEST_DIRNAME/../node_modules/.bin"
  local core_path="/usr/bin:/bin:/usr/sbin:/sbin"
  export PATH="$BATS_MOCK_BINDIR:$test_bin:$package_bin:$node_modules_bin:$core_path"



  # custom setup

  mkdir -p "$BATS_TMPDIR"
  testdir=$(mktemp -d "$BATS_TMPDIR/$BATS_TEST_NAME.XXX") || exit 1

  export NODENV_ROOT=$testdir/nodenv_root
  mkdir -p "$NODENV_ROOT"

  export HOME=$testdir/home
  mkdir -p "$HOME/.config/nodenv"

  export NODENV_HOOK_PATH="$BATS_TEST_DIRNAME/../etc/nodenv.d"
}

teardown() {
  rm -rf "$BATS_TMPDIR" # same as BATS_MOCK_TMPDIR
}

with_file() {
  mkdir -p "$(dirname "$1")"
  cat - > "$1"
}
