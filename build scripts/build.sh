#!/usr/bin/env bash

set -xu

source config.sh

cd ./godot

git checkout $git_commit

scons platform=windows arch=x86_64 d3d12=yes \
    dxc_path=${build_dir}/dxc mesa_libs=${build_dir}/mesa pix_path=${build_dir}/pix \
    ${build_options} \
    module_mono_enabled=yes
    
scons platform=windows vsproj=yes

cd ..
