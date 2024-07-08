# escape=`

# Start from a windows base image.
#FROM mcr.microsoft.com/windows/servercore:ltsc2019-amd64
FROM mcr.microsoft.com/windows:10.0.19042.1889-amd64

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# WORKDIR makes directory if it doesn't exist
ARG BUILD_DIR
WORKDIR ${BUILD_DIR}

# =============================================================================
# Get the required Visual Studio Build Tools components.

ARG BUILD_TOOLS_URL
RUN curl -SL --output vs_buildtools.exe %BUILD_TOOLS_URL% `
    && `
    (start /w vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools" `
    --includeRecommended `
    --add Microsoft.VisualStudio.Workload.VCTools `
    || IF "%ERRORLEVEL%"=="3010" EXIT 0) `
    && `
    del /q vs_buildtools.exe

# =============================================================================
# Get other libraries and sources that will be used for compiling.

# Download and install Python
ARG PYTHON_URL
RUN curl %PYTHON_URL% -o python_installer.exe `
    && `
    python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 `
    && `
    del /q python_installer.exe

# Install SCons
# Python/Pip behaves oddly here when run through the dockerfile, something to do with opening
# subprocesses with invalid file handled causes an error, failing the image build.
# Redirecting stdin to nul (windows equiv of /dev/null) seems to prevent the error. Sometimes...
RUN python -m pip install scons --root c:\ < nul > nul

# Download 7zip
ARG 7ZIP_URL
RUN curl -SL %7ZIP_URL% -o 7zip_installer.exe `
    && `
    7zip_installer.exe /S `
    && `
    del /q 7zip_installer.exe `
    && `
    setx path "%path%;C:\Program Files\7-zip"

# Download and install git
ARG GIT_URL
RUN curl -SL %GIT_URL% -o git_portable.7z.exe `
    && `
    mkdir c:\git `
    && `
    7z x git_portable.7z.exe -oC:\git -y > nul `
    && `
    del /q git_portable.7z.exe `
    && `
    setx path "%path%;C:\git\bin"

# =============================================================================
# Set up build scripts and container entry point.

WORKDIR ${BUILD_DIR}\godot

# Disable all git safe directory warnings, which are thrown because the container user is
# not the owner of the godot repository I am building from, my host machine user does.
RUN git config --global --add safe.directory "*"

# Starts the developer command prompt and launches PowerShell.
ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "-arch=amd64", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
