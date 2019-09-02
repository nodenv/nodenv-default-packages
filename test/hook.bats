#!/usr/bin/env bats

load test_helper

@test "nodenv-install hook auto installs packages" {
  with_file "$NODENV_ROOT/default-packages" <<< fake-package

  run nodenv install 0.10.36

  assert_success
  assert_output -e - <<-OUT
Sourcing .*/etc/nodenv.d/install/default-packages.bash
Installed fake node into $NODENV_ROOT/versions/0.10.36
Executing after_install hooks.
npm invoked with: 'install -g fake-package'
Installed default packages for 0.10.36
OUT
}

@test "failed nodenv-install exits gracefully" {
  run nodenv install --fail 0.10.36

  assert_failure
  assert_line 'Failed installation of 0.10.36'
}
