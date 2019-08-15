#!/usr/bin/env bats

load test_helper

export INSTALL_HOOK="${BATS_TEST_DIRNAME}/../etc/nodenv.d/install/default-packages.bash"

@test "running nodenv-install auto installs packages" {
  with_default_packages_file <<< fake-package

  stub nodenv-prefix '0.10.36 : echo "$NODENV_ROOT/versions/0.10.36"'
  stub nodenv-version-name 'echo 0.10.36'
  stub nodenv-which 'npm : echo "${NODENV_ROOT}/versions/0.10.36/bin/npm"'
  stub nodenv-hooks 'exec : echo ""'

  run nodenv-install 0.10.36

  assert_success
  assert_line 'Installed fake version 0.10.36'
  assert_line "Installed package 'fake-package'@latest"

  unstub nodenv-version-name
  unstub nodenv-which
  unstub nodenv-hooks
}

@test "failed nodenv-install exits gracefully" {
  run nodenv-install fail 0.10.36

  assert_failure
  assert_line 'Failed installation of 0.10.36'
}
