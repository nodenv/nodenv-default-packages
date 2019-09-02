#!/usr/bin/env bats

load test_helper

@test "installs nodenv-default-packages into PREFIX" {
  cd "$BATS_TMPDIR"
  PREFIX="${PWD}/usr" run "${BATS_TEST_DIRNAME}/../install.sh"
  assert_success
  refute_output

  cd usr

  assert [ -s etc/nodenv.d/install/default-packages.bash ]
}

@test "overwrites old installation" {
  cd "$BATS_TMPDIR"
  with_file etc/nodenv.d/install/default-packages.bash <<<""

  PREFIX="$PWD" run "${BATS_TEST_DIRNAME}/../install.sh"
  assert_success
  refute_output

  assert [ -s etc/nodenv.d/install/default-packages.bash ]
  run grep "install_default_packages" etc/nodenv.d/install/default-packages.bash
  assert_success
}
