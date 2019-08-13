#!/usr/bin/env bats

load test_helper

export INSTALL_HOOK="${BATS_TEST_DIRNAME}/../etc/nodenv.d/install/default-packages.bash"

@test "running nodenv-install auto installs packages" {
  with_default_packages_file <<< fake-package

  run nodenv install 0.10.36

  assert_success
  assert_line 'Installed fake version 0.10.36'
  assert_line "Installed package 'fake-package'@latest"
}

@test "failed nodenv-install exits gracefully" {
  run nodenv install fail 0.10.36

  assert_failure
  assert_line 'Failed installation of 0.10.36'
}
