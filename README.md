GoProj
======

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

For now, the easiest way of installing it is by cloning the repository, adding the repos `bin/` folder to 
the `PATH` env variable and setting `GO_TOOL` with the go tool absolute path.

If you're on linux, you can copy & paste this:

```
git clone git://github.com/divoxx/goproj
cd goproj

cat <<EOF >> ~/.bashrc && source ~/.bashrc

# -- Configure GoProj
GO_TOOL=$(which go)"
PATH="$(pwd)/bin:\${PATH}"

EOF
```

On MacOSX, replace `~/.bashrc` with `~/.bash_profile`:

```
git clone git://github.com/divoxx/goproj
cd goproj

cat <<EOF >> ~/.bash_profile && source ~/.bash_profile

# -- Configure GoProj
GO_TOOL=$(which go)"
PATH="$(pwd)/bin:\${PATH}"

EOF
```

Windows is not supported, but one could easily use it through cigwin or similar tool.