if declare -Ff after_install >/dev/null; then
  after_install install_default_packages
else
  echo "nodenv: nodenv-default-packages plugin requires node-build" >&2
fi

install_default_packages() {
  # Only install default packages after successfully installing Node.
  [ "$STATUS" = "0" ] || return 0

  nodenv-default-packages install "$VERSION_NAME"
  echo "Installed default packages for $VERSION_NAME"
}
