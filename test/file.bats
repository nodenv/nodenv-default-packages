#!/usr/bin/env bats

load test_helper

@test "file errors if file not found" {
  run nodenv default-packages file

  assert_failure
  assert_output "default-packages file not found"
}

@test "file finds default-packages in NODENV_ROOT" {
  with_default_packages_file <<< fake-package

  run nodenv default-packages file

  assert_success
  assert_output "$NODENV_ROOT/default-packages"
}

@test "file finds default-packages in default XDG_CONFIG_HOME" {
  cat > $HOME/.config/nodenv/default-packages <<< fake-package

  run nodenv default-packages file

  assert_success
  assert_output "$HOME/.config/nodenv/default-packages"
}

@test "file finds default-packages in configured XDG_CONFIG_HOME" {
  XDG_CONFIG_HOME=$HOME/myconfig
  mkdir -p $XDG_CONFIG_HOME/nodenv
  cat > $XDG_CONFIG_HOME/nodenv/default-packages <<< fake-package

  XDG_CONFIG_HOME=$XDG_CONFIG_HOME run nodenv default-packages file

  assert_success
  assert_output "$XDG_CONFIG_HOME/nodenv/default-packages"
}

@test "file finds default-packages in configured XDG_CONFIG_DIRS" {
  mkdir -p $HOME/myconfig/nodenv
  cat > $HOME/myconfig/nodenv/default-packages <<< fake-package

  XDG_CONFIG_DIRS=$HOME/myconfig:other run nodenv default-packages file

  assert_success
  assert_output "$HOME/myconfig/nodenv/default-packages"
}

@test "file finds default-packages in default XDG_CONFIG_DIRS" {
  skip "can't fake /etc/xdg"
}
