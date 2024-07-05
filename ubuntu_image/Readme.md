# Instructions

## Context

The directory containing the docker files should be in the same parent directory as the godot repository. The source repo will be mounted inside of the docker container and used for building.

## Usage

Ensure image is built and has the latest version of the build scripts:

```bat
docker compose build
```

Make and run a container in interactive mode:

```bat
docker compose run builder
```

You should be within the default build directory. All of the build scripts should be present. Edit `config.sh` as needed. Run `build.sh` to build the godot binaries.

After the binaries are built, the glue files must be generated using the binaries. Currently, rather than build both a windows and linux binary, only windows is being built. So from the host windows machine, the `generate_glue.bat` script should be ran.

After the glue files are generated, return to the container and run `build_managed_libs.sh` to generate the .net libraries.

At this point the windows binaries should be fully built and usable, and are located within the `/bin` directory of the godot source repository.
