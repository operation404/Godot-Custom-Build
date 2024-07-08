cd %BUILD_DIR%\scripts

:: Set up build environment variables
call config.bat

cd %BUILD_DIR%\godot

git checkout %GIT_COMMIT%

scons                                   ^
    dxc_path=c:%BUILD_DIR%\dxc          ^
    mesa_libs=c:%BUILD_DIR%\mesa        ^
    pix_path=c:%BUILD_DIR%\pix          ^
    %BUILD_OPTS%

::FOR %%a in (bin\godot.*.mono.exe) DO %%a --headless --generate-mono-glue modules/mono/glue

::./modules/mono/build_scripts/build_assemblies.py --godot-output-dir=./bin --godot-platform=windows

cd %BUILD_DIR%\scripts
