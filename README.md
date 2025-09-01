# nodenv-default-packages

A [nodenv][] plugin that installs a set of npm packages every time you install a new version of Node.

[![Tests](https://img.shields.io/github/actions/workflow/status/nodenv/nodenv-default-packages/test.yml?label=tests&logo=github)](https://github.com/nodenv/nodenv-default-packages/actions/workflows/test.yml)
[![Latest GitHub Release](https://img.shields.io/github/v/release/nodenv/nodenv-default-packages?label=github&logo=github&sort=semver)](https://github.com/nodenv/nodenv-default-packages/releases/latest)
[![Latest Homebrew Release](<https://img.shields.io/badge/dynamic/regex?label=homebrew-nodenv&logo=homebrew&logoColor=white&url=https%3A%2F%2Fraw.githubusercontent.com%2Fnodenv%2Fhomebrew-nodenv%2Frefs%2Fheads%2Fmain%2FFormula%2Fnodenv-default-packages.rb&search=archive%2Frefs%2Ftags%2Fv(%3F%3Cversion%3E%5Cd%2B.*).tar.gz&replace=v%24%3Cversion%3E>)](https://github.com/nodenv/homebrew-nodenv/blob/main/Formula/nodenv-default-packages.rb)
[![Latest npm Release](https://img.shields.io/npm/v/@nodenv/nodenv-default-packages?logo=npm&logoColor=white)](https://www.npmjs.com/package/@nodenv/nodenv-default-packages/v/latest)

This nodenv plugin hooks into the `nodenv install` command to automatically install `npm` packages every time you install a new version of Node.
It requires the `node-build` plugin to be installed.

Forked from the excellent [`rbenv-default-gems`][rbenv-default-gems] plugin from [sstephenson][sstephenson].

<!-- toc -->

- [Installation](#installation)
  - [Installing as a nodenv plugin](#installing-as-a-nodenv-plugin)
  - [Installing with Homebrew (for macOS users)](#installing-with-homebrew-for-macos-users)
- [Usage](#usage)
  - [default-packages Files](#default-packages-files)
  - [Updating Default Packages](#updating-default-packages)
- [Credits](#credits)

<!-- tocstop -->

## Installation

### Installing as a nodenv plugin

Make sure you have the latest nodenv and node-build versions, then run:

```sh
git clone https://github.com/nodenv/nodenv-default-packages.git $(nodenv root)/plugins/nodenv-default-packages
```

### Installing with Homebrew (for macOS users)

MacOS users can install nodenv-default-packages with the [Homebrew](http://brew.sh) package manager.

_This is the recommended method of installation if you installed nodenv with Homebrew._

```sh
brew install nodenv/nodenv/nodenv-default-packages
```

Or, if you would like to install the latest development release:

```sh
brew install --HEAD nodenv/nodenv/nodenv-default-packages
```

## Usage

nodenv-default-packages automatically installs the packages listed in the [default-packages file(s)](#default-packages-files) file every time you successfully install a new version of Node with `nodenv install`.

Specify packages in `default-packages` by name, one per line.
You may optionally specify a SemVer version spec after the name. For example:

```txt
grunt-cli
jshint ~2.6.3
csslint >= 0.9.0 < 0.10.0
```

Empty lines and lines beginning with a `#` are ignored.

### default-packages Files

nodenv-default-packages reads from `$(nodenv root)/default-packages` as well as `nodenv/default-packages` under all [XDG config directories][xdg].
The XDG config directories searched are `$XDG_CONFIG_HOME` (`$HOME/.config` if unset/empty) and all colon-separated `$XDG_CONFIG_DIRS` (`/etc/xdg` if unset/empty).

### Updating Default Packages

if you update your `$(nodenv root)/default-packages` and want to refresh some or all of your existing node installations you can use commands like this:

```sh
nodenv default-packages install 8.8.1   # Reinstall default packages on Node version 8.8.1
```

```sh
nodenv default-packages install --all   # Reinstall default packages on _all_ installed Node versions
```

> [!NOTE]
> This may take some time.

## Credits

Forked from [Sam Stephenson][sstephenson]'s [rbenv-default-gems][] by [Josh Hagins][jawshooah] and modified for [nodenv][].

[sstephenson]: https://github.com/sstephenson
[rbenv-default-gems]: https://github.com/rbenv/rbenv-default-gems
[jawshooah]: https://github.com/jawshooah
[nodenv]: https://github.com/nodenv/nodenv
[xdg]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
