#!/usr/bin/env bash

git_commit=a4f2ea91a1bd18f70a43ff4c1377db49b56bc3f0

# TODO
# have the docker compose file set up an environment variable for this,
# so that it's all controlled in one place
build_dir=/build

build_options="     \  
target=editor       \  
dev_mode=yes        \  
debug_symbols=yes   \  
dev_build=yes       \  
optimize=debug      \ 
"
