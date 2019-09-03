#!/usr/bin/env bats

load test_helper

@test "install, without file, exits with error" {
  run nodenv default-packages install 1.2.3

  assert_failure
  assert_output "nodenv: default-packages file not found"
}

@test "install, without a version, installs to current node version" {
  nodenv install --no-hooks 10.0.0
  with_file "$NODENV_ROOT/default-packages" <<< fake-package

  NODENV_VERSION=10.0.0 run nodenv default-packages install

  assert_success
  assert_output -p "npm invoked with: install -g fake-package"
}

@test "install accepts node version to which to install" {
  nodenv install --no-hooks 10.0.0
  with_file "$NODENV_ROOT/default-packages" <<< fake-package

  run nodenv default-packages install 10.0.0

  assert_success
  assert_output -p "npm invoked with: install -g fake-package"
}

@test "install npm-installs single package" {
  nodenv install --no-hooks 10.0.0
  with_file "$NODENV_ROOT/default-packages" <<< fake-package

  run nodenv default-packages install 10.0.0

  assert_success
  assert_output -p "npm invoked with: install -g fake-package"
}

@test "install npm-installs multiple packages in one command" {
  nodenv install --no-hooks 10.0.0
  with_file "$NODENV_ROOT/default-packages" <<-PKGS
	pkg1
	pkg2
PKGS

  run nodenv default-packages install 10.0.0

  assert_success
  assert_output -p "npm invoked with: install -g pkg1 pkg2"
}

@test "install does not invoke npm if no packages to install" {
  nodenv install --no-hooks 10.0.0
  with_file "$NODENV_ROOT/default-packages" <<<""

  run nodenv default-packages install 10.0.0

  assert_success
  refute_output
}
