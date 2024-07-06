# escape=`

# Use the latest Windows Server Core 2019 image.
# My windows 10 machine is outdated and can't run the newest 2022 image.
FROM mcr.microsoft.com/windows/servercore:ltsc2019-amd64

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

ARG BUILD_DIR
ARG GIT_COMMIT
ARG BUILD_TOOLS_URL
ARG PYTHON_URL
ARG DXC_URL
ARG MESA_URL
ARG PIX_URL

# =============================================================================
# Get the required Visual Studio Build Tools components.

RUN curl -SL --output vs_buildtools.exe %BUILD_TOOLS_URL%
RUN (start /w vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools" `
    # Workloads (groups of components), installs required only by default
     --includeRecommended `
    # --includeOptional `
    --add Microsoft.VisualStudio.Workload.VCTools `
    --add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools `
    || IF "%ERRORLEVEL%"=="3010" EXIT 0)
RUN del /q vs_buildtools.exe

# WORKDIR makes directory if it doesn't exist
WORKDIR ${BUILD_DIR}

# =============================================================================
# Get other libraries and sources that will be used for compiling.

# Get dx12 shader compiler for dx12 support
RUN curl -SL %DXC_URL% --output dxc.zip
RUN mkdir dxc && tar -xf dxc.zip -C dxc && del /q dxc.zip

# Get Mesa librariers for godot, which they already statically compile
RUN curl -SL %MESA_URL% --output mesa.zip
RUN mkdir mesa && tar -xf mesa.zip -C mesa && del /q mesa.zip

# Get pix support, a performance and debug app for dx12 applications
RUN curl -SL %PIX_URL% --output pix.zip
RUN mkdir pix && tar -xf pix.zip -C pix && del /q pix.zip

# Download and install Python
RUN curl %PYTHON_URL% -o python_installer.exe
RUN python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
RUN del /q python_installer.exe

# Install SCons
# Python/Pip behaves oddly here when run through the dockerfile, something to do with opening
# subprocesses with invalid file handled causes an error, failing the image build.
# Redirecting stdin to nul (windows equiv of /dev/null) seems to prevent the error. Sometimes.
RUN python -m pip install scons --root c:\ < nul > nul

# =============================================================================
# Set up build scripts and container entry point.

COPY ["./build scripts", "${BUILD_DIR}"]

# Starts the developer command prompt and launches PowerShell.
ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "-arch=amd64", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
