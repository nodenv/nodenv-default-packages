#!/usr/bin/env bats

load test_helper

@test "list, without file, exits with error" {
  run nodenv default-packages list

  assert_failure
  refute_output "No default-packages file found"
}

@test "list default-packages" {
  with_file "$NODENV_ROOT/default-packages" <<< fake-package

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
