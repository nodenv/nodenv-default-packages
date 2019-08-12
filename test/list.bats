#!/usr/bin/env bats

load test_helper

@test "list, without file, exits with error" {
  run nodenv-default-packages list

  assert_failure
  refute_output "No default-packages file found"
}
