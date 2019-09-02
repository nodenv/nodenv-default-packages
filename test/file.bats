#!/usr/bin/env bats

load test_helper

@test "file errors if file not found" {
  run nodenv default-packages file

  assert_failure
  assert_output "nodenv: default-packages file not found"
}

@test "file finds default-packages in NODENV_ROOT" {
  with_file "$NODENV_ROOT/default-packages" <<<""

  run nodenv default-packages file

  assert_success
  assert_output "$NODENV_ROOT/default-packages"
}

@test "file finds default-packages in default XDG_CONFIG_HOME" {
  with_file "$HOME/.config/nodenv/default-packages" <<<""

  run nodenv default-packages file

  assert_success
  assert_output "$HOME/.config/nodenv/default-packages"
}

@test "file finds default-packages in configured XDG_CONFIG_HOME" {
  XDG_CONFIG_HOME=$HOME/myconfig
  with_file "$XDG_CONFIG_HOME/nodenv/default-packages" <<<""

  XDG_CONFIG_HOME="$XDG_CONFIG_HOME" run nodenv default-packages file

  assert_success
  assert_output "$XDG_CONFIG_HOME/nodenv/default-packages"
}

@test "file finds default-packages in configured XDG_CONFIG_DIRS" {
  with_file "$HOME/myconfig/nodenv/default-packages" <<<""

  XDG_CONFIG_DIRS="$HOME/myconfig:other" run nodenv default-packages file

  assert_success
  assert_output "$HOME/myconfig/nodenv/default-packages"
}

@test "file finds default-packages in default XDG_CONFIG_DIRS" {
  skip "can't fake /etc/xdg"
}

@test "file finds multiple files" {
  with_file "$NODENV_ROOT/default-packages" <<<""
  with_file "$HOME/.config/nodenv/default-packages" <<<""
  with_file "$HOME/myconfig/nodenv/default-packages" <<<""
  with_file "$HOME/theirconfig/nodenv/default-packages" <<<""

  XDG_CONFIG_DIRS="$HOME/myconfig:$HOME/theirconfig" run nodenv default-packages file

  assert_success
  assert_output - <<-OUT
	$NODENV_ROOT/default-packages
	$HOME/.config/nodenv/default-packages
	$HOME/myconfig/nodenv/default-packages
	$HOME/theirconfig/nodenv/default-packages
OUT
}
