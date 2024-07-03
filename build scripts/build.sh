#!/usr/bin/env bash

set -xu

source config.sh

cd ./godot

git checkout $git_commit

scons dxc_path=${build_dir}/dxc mesa_libs=${build_dir}/mesa pix_path=${build_dir}/pix \
    ${build_options}
    
scons platform=windows vsproj=yes

cd ..
