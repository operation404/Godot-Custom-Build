#!/usr/bin/env bash

cd ./godot

./modules/mono/build_scripts/build_assemblies.py --godot-output-dir=./bin --godot-platform=windows

cd ..
