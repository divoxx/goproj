#!/bin/bash

current_path=$(dirname $0)
bin_dir="${current_path}/bin"

PATH=$PATH:${bin_dir}

alias go="goproj-go"
