FROM ubuntu:latest

ARG GIT_COMMIT
ARG DXC_LINK
ARG MESA_LINK
ARG PIX_LINK
ARG BUILD_DIR

# Install the requirements for building Godot
RUN apt-get update
RUN apt-get install -y \
    build-essential \
    scons \
    pkg-config \
    libx11-dev \
    libxcursor-dev \
    libxinerama-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libasound2-dev \
    libpulse-dev \
    libudev-dev \
    libxi-dev \
    libxrandr-dev \
    libwayland-dev \
    # Need mingw to cross compile to windows
    mingw-w64 \ 
    git \
    wget \
    unzip \
    # Need the dotnet SDK to build godot with c# support
    dotnet-sdk-8.0 \
    # Handy tool for removing carriage returns in files copied from windows
    dos2unix \
    nano

# Configure mingw to run in posix mode, as there's a bug on ubuntu causing
# it to run in win32 mode by default. We want 64.
# https://github.com/godotengine/godot/issues/9258#issuecomment-315612079
RUN update-alternatives --set x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix
RUN update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix

# Make and navigate to the directory used for building
RUN mkdir -p ${BUILD_DIR}
WORKDIR "${BUILD_DIR}"

# =============================================================================
# Get other libraries and sources that will be used for compiling.

# Get dx12 shader compiler for dx12 support
ENV dxc_ver=dxc_2024_05_24
RUN wget ${DXC_LINK} -O dxc.zip
RUN unzip dxc.zip -d dxc && rm dxc.zip

# Get Mesa librariers for godot, which they already statically compile
ENV mesa_ver=godot-nir-23.1.9
RUN wget ${MESA_LINK} -O mesa.zip
RUN unzip mesa.zip -d mesa && rm mesa.zip

# Get pix support, a performance and debug app for dx12 applications
ENV pix_ver=1.0.240308001
RUN wget ${PIX_LINK} -O pix.zip
RUN unzip pix.zip -d pix && rm pix.zip

# =============================================================================
# Copy build scripts into the image and clean any windows carriage return chars

COPY ["./build scripts", "${BUILD_DIR}"]
RUN dos2unix *.sh

# =============================================================================
# Get the actual source code for compiling

# NOTE
# I am instead using docker compose to mount a directory containing my fork of
# the godot repo from my filesystem into the container.

# If using a version with source code packaged in a zip, can just download
# the zip and unzip it. Make sure to navigate into directory afterwards.
# ENV version=4.3-beta1
# RUN wget https://github.com/godotengine/godot-builds/archive/refs/tags/${version}.zip
# RUN unzip ${version}.zip

# NOTE : Otherwise, have to clone and checkout the correct branch and commit/tag
# RUN git clone https://github.com/godotengine/godot.git
# WORKDIR "${BUILD_DIR}/godot"
# # RUN git switch master
# RUN git checkout ${GIT_COMMIT}

# Example for how to download and install a module.
# The repo name may not match what the actual name of the module is
# required to be by godot for compilation, so make sure to check and
# rename the module if so.
#
# Make sure to navigate BACK to the base directory after!

# Set cwd to modules folder, download and install any desired modules
# WORKDIR "/godot-${version}/modules"
# RUN git clone https://github.com/Zylann/godot_voxel.git
# RUN mv godot_voxel godot_voxel
# WORKDIR "/godot-${version}"

# =============================================================================
# Build Godot

# Windows build
# RUN scons platform=windows target=editor arch=x86_64 d3d12=yes \
#     dxc_path=${BUILD_DIR}/dxc mesa_libs=${BUILD_DIR}/mesa pix_path=${BUILD_DIR}/pix \
#     # Options for build modes:
#     # dev_mode=yes \
#     # production=yes \
#     module_mono_enabled=yes

# Also generate visual studio solution files
# RUN scons platform=windows vsproj=yes

# Other example builds and options on docs
# https://docs.godotengine.org/en/latest/contributing/development/compiling/introduction_to_the_buildsystem.html
# https://docs.godotengine.org/en/latest/contributing/development/compiling/compiling_for_linuxbsd.html
# https://docs.godotengine.org/en/latest/contributing/development/compiling/compiling_for_windows.html
