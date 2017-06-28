#!/usr/bin/env bash
if declare -Ff after_install >/dev/null; then
  after_install install_default_packages
else
  echo "nodenv: nodenv-default-packages plugin requires node-build" >&2
fi

install_default_packages() {
  # Only install default packages after successfully installing Node.
  [ "$STATUS" = "0" ] || return 0

  if [ -f "${NODENV_ROOT}/default-packages" ]; then
    local line package_name package_version package_spec

    # Read package names and versions from $NODENV_ROOT/default-packages.
    while IFS=" " read -r -a line; do

      # Skip empty lines.
      [ "${#line[@]}" -gt 0 ] || continue

      # Skip comment lines that begin with `#`.
      [ "${line[0]:0:1}" != "#" ] || continue

      package_name="${line[0]}"
      package_version="${line[*]:1}"

      if [ -n "$package_version" ]; then
        package_spec="${package_name}@${package_version}"
      else
        package_spec="$package_name"
      fi

      # Invoke `npm install -g` in the just-installed Node.
      NODENV_VERSION="$VERSION_NAME" nodenv-exec npm install -g "$package_spec" || {
        echo "nodenv: error installing package \`$package_name'"
      } >&2

    done < "${NODENV_ROOT}/default-packages"
  fi
}
