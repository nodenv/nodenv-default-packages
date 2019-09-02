#!/usr/bin/env bats

load test_helper

@test "install, without file, exits with error" {
  run nodenv default-packages install 1.2.3

  assert_failure
  assert_output "nodenv: default-packages file not found"
}

@test "install, without a version, installs to current node version" {
  nodenv install --no-hooks 10.0.0
  with_file "$NODENV_ROOT/default-packages" <<< fake-package

  NODENV_VERSION=10.0.0 run nodenv default-packages install

  assert_success
  assert_output -p "npm invoked with: 'install -g fake-package'"
}

@test "install accepts node version to which to install" {
  nodenv install --no-hooks 10.0.0
  with_file "$NODENV_ROOT/default-packages" <<< fake-package

  run nodenv default-packages install 10.0.0

  assert_success
  assert_output -p "npm invoked with: 'install -g fake-package'"
}

@test "install npm-installs single package" {
  nodenv install --no-hooks 10.0.0
  with_file "$NODENV_ROOT/default-packages" <<< fake-package

  run nodenv default-packages install 10.0.0

  assert_success
  assert_output -p "npm invoked with: 'install -g fake-package'"
}

@test "install combines all default-packages files" {
  nodenv install --no-hooks 10.0.0
  with_file "$NODENV_ROOT/default-packages" <<< pkg-from-nodenv-root
  with_file "$HOME/.config/nodenv/default-packages" <<< pkg-from-config-home
  with_file "$HOME/myconfig/nodenv/default-packages" <<< pkg-from-config-dirs1
  with_file "$HOME/theirconfig/nodenv/default-packages" <<< pkg-from-config-dirs2

  XDG_CONFIG_DIRS="$HOME/myconfig:$HOME/theirconfig" NODENV_VERSION=10.0.0 run nodenv default-packages install

  assert_success
  assert_output -p "npm invoked with: 'install -g pkg-from-nodenv-root'"
  assert_output -p "npm invoked with: 'install -g pkg-from-config-home'"
  assert_output -p "npm invoked with: 'install -g pkg-from-config-dirs1'"
  assert_output -p "npm invoked with: 'install -g pkg-from-config-dirs2'"
}
