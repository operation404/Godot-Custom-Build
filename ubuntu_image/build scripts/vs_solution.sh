#!/usr/bin/env bash

set -xu

source config.sh

cd ./godot

git checkout $git_commit

# I think vsproj stops scons from making the binary, so it has to be done in a separate step?
pyston-scons                        \
    dxc_path=${BUILD_DIR}/dxc       \
    mesa_libs=${BUILD_DIR}/mesa     \
    pix_path=${BUILD_DIR}/pix       \
    ${build_options}                \
    vsproj=yes

cd ..
