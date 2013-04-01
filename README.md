GoProj
======

What is it?
-----------

Automatially manage Go(lang) project workspaces by looking for a `.goproj` file up in the tree and setting
`GOPATH` to it's location.


Introduction
------------

Simple wrapper around Go(lang) build tool that simplify having project-specific `GO_PATH` configurations.

Because of the way `go get` works and how dependencies are managed, ideally, each project would have it's 
own workspace (GO_PATH) where it's source code and dependencies would exist isolated from other projects.
Managing `GO_PATH` can be a pain though.

GoProj try to solve this by wrapping the go executable, looking for a `.goproj` file up from the current
directory and setting `GO_PATH` to that folder prior to delegating the call to the go tool.

For example, given the following folder structure.

```
-- projects
  |- foo
    |- .gopath
    |- src
      |- github.com
        |- divoxx
          |- foo
            |- foo.go
            |- foo_test.go
```

If you run `go build` from inside `projects/src/github.com/divoxx/foo`, the wrapper will go up the path
looking for the first .gopath location, set `GO_PATH="/projects/foo"` and delegate to the original go tool.

The content of `.gopath` is irrelevant, it's recommended to simply `touch .gopath`.

In case a `.gopath` is not found, the wrapper won't touch the `GO_PATH` env variable and will just delegate
to go tool.

Installation
------------

For now, the easiest way of installing it is by cloning the repository, prepending the repo's `bin/` folder to 
the `PATH` env variable and setting the `GOTOOL` env variable with the go tool's absolute path.

If you're on linux, you can copy & paste this (line breaks in `cat` are important):

```
git clone git://github.com/divoxx/goproj
cd goproj


cat <<EOF >> ~/.bashrc && source ~/.bashrc


# -- Configure GoProj
export GOTOOL="$(which go)"
export PATH="$(pwd)/bin:\${PATH}"
EOF
```

On MacOSX, replace `~/.bashrc` with `~/.bash_profile`:

```
git clone git://github.com/divoxx/goproj
cd goproj

cat <<EOF >> ~/.bash_profile && source ~/.bash_profile


# -- Configure GoProj
export GOTOOL="$(which go)"
export PATH="$(pwd)/bin:\${PATH}"
EOF
```

Windows is not supported, but one could easily use it through cigwin or similar tool.

License
-------

Copyright (c) 2013 Rodrigo Kochenburger <divoxx at gmail dot com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.