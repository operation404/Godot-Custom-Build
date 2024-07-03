#!/usr/bin/env bash

set -xu

source config.sh

cd ./godot

scons --clean ${build_options}

cd ..
