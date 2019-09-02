# nodenv-default-packages

[![Build Status](https://travis-ci.org/nodenv/nodenv-default-packages.svg)](https://travis-ci.org/nodenv/nodenv-default-packages)

This nodenv plugin hooks into the `nodenv install` command to automatically install `npm` packages every time you install a new version of Node.
It requires the `node-build` plugin to be installed.

Forked from the excellent [`rbenv-default-gems`][rbenv-default-gems] plugin from [sstephenson][sstephenson].

<!-- toc -->

- [Installation](#installation)
  * [Installing as a nodenv plugin](#installing-as-a-nodenv-plugin)
  * [Installing with Homebrew (for OS X users)](#installing-with-homebrew-for-os-x-users)
- [Usage](#usage)
  * [Updating Default Packages](#updating-default-packages)
- [Credits](#credits)

<!-- tocstop -->

## Installation

### Installing as a nodenv plugin

Make sure you have the latest nodenv and node-build versions, then run:

    git clone https://github.com/nodenv/nodenv-default-packages.git $(nodenv root)/plugins/nodenv-default-packages

### Installing with Homebrew (for OS X users)

Mac OS X users can install nodenv-default-packages with the [Homebrew](http://brew.sh) package manager.

*This is the recommended method of installation if you installed nodenv with Homebrew.*

```
$ brew install nodenv/nodenv/nodenv-default-packages
```

Or, if you would like to install the latest development release:

```
$ brew install --HEAD nodenv/nodenv/nodenv-default-packages
```

## Usage

nodenv-default-packages automatically installs the packages listed in the `$(nodenv root)/default-packages` file every time you successfully install a new version of Node with `nodenv install`.

Specify packages in `$(nodenv root)/default-packages` by name, one per line.
You may optionally specify a semver version spec after the name. For example:

    grunt-cli
    jshint ~2.6.3
    csslint >= 0.9.0 < 0.10.0

Blank lines and lines beginning with a `#` are ignored.

### Updating Default Packages

if you update your `$(nodenv root)/default-packages` and want to refresh some or all of your existing node installations you can use commands like this:

    nodenv default-packages install 8.8.1   # Reinstall default packages on Node version 8.8.1
    nodenv default-packages install --all   # Reinstall default packages on _all_ installed Node versions

*NOTE:* This may take some time.

## Credits

Forked from [Sam Stephenson][sstephenson]'s [rbenv-default-gems][] by [Josh Hagins][jawshooah] and modified for [nodenv][].

[sstephenson]: https://github.com/sstephenson
[rbenv-default-gems]: https://github.com/rbenv/rbenv-default-gems
[jawshooah]: https://github.com/jawshooah
[nodenv]: https://github.com/nodenv/nodenv
