#!/bin/bash

# https://github.com/mstruebing/tldr
mkdir -p ~/go/bin/
mkdir -p ~/.cache/

cp ./tldr ~/go/bin/
tar -C ~/.cache/ -xf ./tldr.tar.xz