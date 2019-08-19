#!/usr/bin/env bats

load test_helper

@test "install, without file, exits with error" {
  run nodenv default-packages install 1.2.3

  assert_failure
  refute_output "No default-packages file found"
}
