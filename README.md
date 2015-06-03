# nodenv-default-packages

This nodenv plugin hooks into the `nodenv install` command to automatically
install `npm` packages every time you install a new version of Node. It
requires the `node-build` plugin to be installed.

Forked from the excellent [`rbenv-default-gems`][rbenv-default-gems] plugin from
[sstephenson][sstephenson].

## Installation

### Installing as a nodenv plugin

Make sure you have the latest nodenv and node-build versions, then run:

    git clone https://github.com/jawshooah/nodenv-default-packages.git $(nodenv root)/plugins/nodenv-default-packages

### Installing with Homebrew (for OS X users)

Mac OS X users can install nodenv-default-packages with the
[Homebrew](http://brew.sh) package manager.

*This is the recommended method of installation if you installed nodenv
 with Homebrew.*

```
$ brew install jawshooah/nodenv/nodenv-default-packages
```

Or, if you would like to install the latest development release:

```
$ brew install --HEAD jawshooah/nodenv/nodenv-default-packages
```

## Usage

nodenv-default-packages automatically installs the packages listed in the
`$(nodenv root)/default-packages` file every time you successfully install a new
version of Node with `nodenv install`.

Specify packages in `$(nodenv root)/default-packages` by name, one per line. You may
optionally specify a semver version spec after the name. For example:

    grunt-cli
    jshint ~2.6.3
    csslint >= 0.9.0 < 0.10.0

Blank lines and lines beginning with a `#` are ignored.

## License

(The MIT License)

Copyright (c) 2015 Joshua Hagins

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[rbenv-default-gems]: https://github.com/sstephenson/rbenv-default-gems
[sstephenson]: https://github.com/sstephenson
