#!/usr/bin/env bash

set -xu

source config.sh

cd ./godot

git checkout $git_commit

scons platform=windows target=editor arch=x86_64 d3d12=yes \
    dxc_path=${build_dir}/dxc mesa_libs=${build_dir}/mesa pix_path=${build_dir}/pix \
    module_mono_enabled=yes
    # Options for build modes:
    # dev_mode=yes \
    # production=yes \
    
scons platform=windows vsproj=yes

cd ..
