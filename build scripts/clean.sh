#!/usr/bin/env bash

set -xu

source config.sh

cd ./godot

pyston-scons --clean                \
    dxc_path=${BUILD_DIR}/dxc       \
    mesa_libs=${BUILD_DIR}/mesa     \
    pix_path=${BUILD_DIR}/pix       \
    ${build_options}

cd ..
