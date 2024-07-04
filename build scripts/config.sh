#!/usr/bin/env bash

git_commit=a4f2ea91a1bd18f70a43ff4c1377db49b56bc3f0

# TODO
# have the docker compose file set up an environment variable for this,
# so that it's all controlled in one place
build_dir=/build

build_options="                 \
platform=windows                \
target=editor                   \
arch=x86_64                     \
d3d12=yes                       \
module_mono_enabled=yes         \
dev_mode=no                     \
dev_build=yes                   \
vsproj=yes                      \
debug_symbols=yes               \
separate_debug_symbols=yes      \
optimize=debug                  \
scu_build=yes                   \
"
# dev_mode treats all warnings as errors
# dev_build disables optimizations and allows symbol generation
# debug_symbols actually generates the symbols
# separate_debug_symbols debug symbols are in a different file separate from the binary
# scu_build compiles one big unit, faster to iterate but not for production
#
# https://docs.godotengine.org/en/stable/contributing/development/compiling/introduction_to_the_buildsystem.html
# https://docs.godotengine.org/en/stable/contributing/development/compiling/compiling_for_linuxbsd.html
# https://docs.godotengine.org/en/stable/contributing/development/compiling/compiling_for_windows.html
# https://docs.godotengine.org/en/stable/contributing/development/compiling/compiling_with_dotnet.html
# https://docs.godotengine.org/en/stable/contributing/development/configuring_an_ide/visual_studio.html#doc-configuring-an-ide-vs
