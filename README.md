GoProj
======

What is it?
-----------

Automatially manage Go(lang) project workspaces by looking for a `.goproj` file up in the tree and
prepending it's location to the `GOPATH` env variable.

Introduction
------------

Simple wrapper around Go(lang) build tool that simplify having project-specific `GOPATH` configurations.

Because of the way `go get` works and how dependencies are managed, ideally, each project would have it's 
own workspace (GOPATH) where it's source code and dependencies would exist isolated from other projects.
Managing `GOPATH` can be a pain though.

GoProj try to solve that by making it easier to switch between project specifics GOPATH configurations. It
searches for a `.goproj` file up in the directory tree and if it finds one, it prepend that folder to GOPATH.

There are two executables available: `goproj` and `go`. The former gives more options and flexibility while
the later gives more simplicity and transparency.

The `goproj` executable is the script that does the heavy work. It looks for the `.goproj` file, setup GOPATH
and dispatch a command or open a new shell with GOPATH set properly.

On the other hand, `go` is a wrapper around the original go tool that uses `goproj` to setup the env and call
the original tollchain.

For example, given one have GOPATH="/home/john/gopath" and the following folder strucure.

```
-- /home/john/projects/foo
  |- .goproj
  |- src
    |- github.com
      |- divoxx
        |- foo
          |- foo.go
          |- foo_test.go
```

If you run `go build` from inside `/home/john/projects/foo/github.com/divoxx/foo` the code will be compiled with
`GOPATH` set to `/home/john/projects/foo:/home/john/gopath`.

Notes:

  * The content of `.goproj` is irrelevant, it's recommended to simply `touch .goproj`.
  * In case a `.goproj` is not found, the wrapper won't touch the `GOPATH` env variable and will just delegate to go tool.

Installation
------------

For now, the easiest way of installing it is by cloning the repository, prepending the repo's `bin/` folder to 
the `PATH` env variable and setting the `GOTOOL` env variable with the go tool's absolute path.

If you're on linux, you can copy & paste this (line break in `cat` is important if file doesn't have a leading linebreak):

```bash
git clone git://github.com/divoxx/goproj
cd goproj
cat <<EOF >> ~/.bashrc && source ~/.bashrc

export GOTOOL="$(which go)"
export PATH="$(pwd)/bin:\${PATH}"
EOF
```

On MacOSX, replace `~/.bashrc` with `~/.bash_profile`:

```bash
git clone git://github.com/divoxx/goproj
cd goproj
cat <<EOF >> ~/.bash_profile && source ~/.bash_profile

export GOTOOL="$(which go)"
export PATH="$(pwd)/bin:\${PATH}"
EOF
```

Windows is not supported, but one could easily use it through cigwin or similar tool.

Usage
-----

**goproj**

```
Usage: goproj [ -h | -c COMMAND | -s ] [ -x ] -- ARGS

Search for a .goproj file up in the directory tree. If it finds one,
prepend it's directory to the GOPATH env variable. After finding a file
or reaching your root folder (usually "/"), it executes the given command.

Options:
  -h    show this screen
  -c    setup GOPATH and run COMMAND
  -s    open a new shell with GOPATH set
        shortcut to 'goproj -c ${SHELL}'
  -x    set GOPATH strictly to your project path instead of appending
        skipping the search for pkgs in the original GOPATH folder

Any ARGS provided after the -- will be passed as is to the command or shell.

Examples:

  goproj -c godoc -- -http=:6060
  goproj -s

PROTIP: goproj contains a wrapper to the go tool which automatically setup
GOPATH and execute the go tool command properly. So, one can easily do:

  go build -a -n

And it will be the same as:

  goproj -c go -- build -a -n
```

**go**

Exactly the same as the original go tool.

License
-------

Copyright (c) 2013 Rodrigo Kochenburger <divoxx at gmail dot com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
