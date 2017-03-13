GoProj
======

**IMPORTANT: This project is not being maintained anymore**

GoProj makes it easier to manage project-specific GOPATH entries. It looks for a .goproj
file up in the directory tree and if it finds one, prepends the file location to the GOPATH
environment variable.

Installation
------------


1. Clone the repository

   ```bash
   git clone git://github.com/divoxx/goproj
   ```

3. Enter the project folder

   ```bash
   cd goproj
   ```

2. Add the `bin/` folder to your PATH

   ```bash
   echo "export PATH=\"$(pwd)/bin:${PATH}\"" >> ~/.bashrc
   ```

3. Alias the `go` command to the `goproj-go` executable:

   ```bash
   echo "alias go=\"goproj-go\"" >> ~/.bashrc
   ```

4. Optionaly reload your bashrc

   ```bash
   source ~/.bashrc
   ```
   
If you're on OS X, use `~/.bash_profile` instead of `~/.bashrc`.

Usage
-----

Simply go into your project's folder and `touch .goproj`. Now goproj will recognize this folder
as a _go path_ and will automatically prepend it to $GOPATH when you run goproj (or goproj-go) from
within that directory (or a subdirectory).

Your projects will need to follow the same directory structure of any GOPATH. For example, a new project
would look like this:

```
$ ls -1Ap ~/projects/foo
.goproj
bin/
pkg/
src/
```

Any go command that you run from whithin that `~/projects/foo`, or any subdirectory, `~/projects/foo` will
be prepended to $GOPATH, properly resolving any dependencies during the build process. Also, if you `go get` 
or `go install` something, it will be installed inside that folder.

```
Usage: goproj [options] [--] COMMAND

Options:
  -h    show this screen
  -x    set GOPATH strictly to your project path, not keeping the original
  -s    open a new shell with the environment setup to the project
  -v    show the version

Description:

  Search for a .goproj file up in the directory tree. If one is found, prepend
  it's directory to the GOPATH env variable and execute COMMAND.

  If no .goproj file is found, it stops when it reaches the root folder, and
  executes COMMAND

Examples:

  goproj godoc -http=:6060
  goproj -s

Go tool wrapper:

  goproj comes with the goproj-go executable, which wraps the go tool, setting up
  the environment prior to actually executing the toolchain command.

  To take full advantage of it, it's recommended to alias the "go" command to it:

    alias go="goproj-go"

  After setting the alias, one can simply do:

    go build -a -n

  And it will in fact execute:

    goproj -- go build -a -n
```

### Vim

To use goproj with vim and the go-vim plugin, vim must be set to use an interactive bash shell. Add the following to your vimrc:

```
set shell=/bin/bash\ -i " Allow bash aliases
```

In order for goproj-go to correctly recognize the workspace, vim's working directory must be set to the directory containing the ```.goproj```.

License
-------

Copyright (c) 2013 Rodrigo Kochenburger <divoxx at gmail dot com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
