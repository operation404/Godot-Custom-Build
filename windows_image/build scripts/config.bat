set BUILD_OPTS=                 ^
platform=windows                ^
target=editor                   ^
arch=x86_64                     ^
d3d12=yes                       ^
module_mono_enabled=no          ^
dev_mode=no                     ^
dev_build=yes                   ^
debug_symbols=yes               ^
separate_debug_symbols=yes      ^
optimize=debug                  ^
scu_build=yes                   ^
scu_limit=1024                  ^
vs_proj=no

:: dev_mode - treats all warnings as errors, verbose, builds unit tests
:: dev_build - disables optimizations and allows symbol generation
:: debug_symbols - actually generates the symbols
:: separate_debug_symbols - debug symbols are in a different file separate from the binary
:: scu_build - compiles one big unit, faster to iterate but not for production
::
:: use_llvm / linker=lld - use clang+lld for building. clang can make pdb files
::
:: https://docs.godotengine.org/en/stable/contributing/development/compiling/introduction_to_the_buildsystem.html
:: https://docs.godotengine.org/en/stable/contributing/development/compiling/compiling_for_linuxbsd.html
:: https://docs.godotengine.org/en/stable/contributing/development/compiling/compiling_for_windows.html
:: https://docs.godotengine.org/en/stable/contributing/development/compiling/compiling_with_dotnet.html
:: https://docs.godotengine.org/en/stable/contributing/development/configuring_an_ide/visual_studio.html#doc-configuring-an-ide-vs
