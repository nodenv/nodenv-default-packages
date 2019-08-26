#!/usr/bin/env bats

load test_helper

@test "install, without file, exits with error" {
  run nodenv default-packages install 1.2.3

  assert_failure
  assert_output "default-packages file not found"
}

@test "install, without a version, installs to current node version" {
  nodenv install --no-hooks 10.0.0
  with_default_packages_file <<< fake-package

  NODENV_VERSION=10.0.0 run nodenv default-packages install

  assert_success
  assert_output -p "npm invoked with: 'install -g fake-package'"
}

@test "install accepts node version to which to install" {
  nodenv install --no-hooks 10.0.0
  with_default_packages_file <<< fake-package

  run nodenv default-packages install 10.0.0

  assert_success
  assert_output -p "npm invoked with: 'install -g fake-package'"
}

@test "install npm-installs single package" {
  nodenv install --no-hooks 10.0.0
  with_default_packages_file <<< fake-package

  run nodenv default-packages install 10.0.0

  assert_success
  assert_output -p "npm invoked with: 'install -g fake-package'"
}
