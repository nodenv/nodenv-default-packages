#!/usr/bin/env bats

load test_helper

@test "list, without file, exits with error" {
  run nodenv default-packages list

  assert_failure
  refute_output "No default-packages file found"
}

@test "list default-packages" {
  with_file "$NODENV_ROOT/default-packages" <<<fake-package

  run nodenv default-packages list

  assert_success
  assert_output "fake-package"
}

@test "list skips comments and empty lines" {
  with_file "$NODENV_ROOT/default-packages" <<-PKGS
  fake-package

  # comment

  another-package
PKGS

  run nodenv default-packages list

  assert_success
  assert_output - <<-OUT
fake-package
another-package
OUT
}

@test "list handles packages with scopes" {
  with_file "$NODENV_ROOT/default-packages" <<-PKGS
	@fake/pkg1
	@fake/pkg2 ~1.2.3
	pkg3
	pkg4 >= 0.9.0 < 0.10.0
PKGS

  run nodenv default-packages list

  assert_success
  assert_output - <<-OUT
	@fake/pkg1
	@fake/pkg2@'~1.2.3'
	pkg3
	pkg4@'>= 0.9.0 < 0.10.0'
OUT
}

@test "list wraps version spec in quotes" {
  with_file "$NODENV_ROOT/default-packages" <<-PKGS
	@fake/pkg1
	@fake/pkg2 ~1.2.3
	pkg3
	pkg4 >= 0.9.0 < 0.10.0
PKGS

  run nodenv default-packages list

  assert_success
  assert_output - <<-OUT
	@fake/pkg1
	@fake/pkg2@'~1.2.3'
	pkg3
	pkg4@'>= 0.9.0 < 0.10.0'
OUT
}

@test "list combines all default-packages files" {
  with_file "$NODENV_ROOT/default-packages" <<<pkg-from-nodenv-root
  with_file "$HOME/.config/nodenv/default-packages" <<<pkg-from-config-home
  with_file "$HOME/myconfig/nodenv/default-packages" <<<pkg-from-config-dirs1
  with_file "$HOME/theirconfig/nodenv/default-packages" <<<pkg-from-config-dirs2

  XDG_CONFIG_DIRS="$HOME/myconfig:$HOME/theirconfig" run nodenv default-packages list

  assert_success
  assert_output - <<-OUT
	pkg-from-nodenv-root
	pkg-from-config-home
	pkg-from-config-dirs1
	pkg-from-config-dirs2
OUT
}

@test "list handles filenames with spaces" {
  with_file "$HOME/my config/nodenv/default-packages" <<<pkg-from-config-dirs1
  with_file "$HOME/their config/nodenv/default-packages" <<<pkg-from-config-dirs2

  XDG_CONFIG_DIRS="$HOME/my config:$HOME/their config" run nodenv default-packages list

  assert_success
  assert_output - <<-OUT
	pkg-from-config-dirs1
	pkg-from-config-dirs2
OUT
}
