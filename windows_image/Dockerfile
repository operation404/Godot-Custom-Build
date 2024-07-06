# escape=`

# Use the latest Windows Server Core 2019 image.
# My windows 10 machine is outdated and can't run the newest 2022 image.
FROM mcr.microsoft.com/windows/servercore:ltsc2019-amd64

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

ARG BUILD_DIR
ARG GIT_COMMIT
ARG PYTHON_URL
ARG DXC_URL
ARG MESA_URL
ARG PIX_URL

# Download the Build Tools bootstrapper and install desired build tools components.
RUN curl -SL --output vs_buildtools.exe https://aka.ms/vs/17/release/vs_buildtools.exe
RUN (start /w vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools" `
    #--includeRecommended --includeOptional `
    --add Microsoft.VisualStudio.Workload.VCTools `
    --add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools `
    || IF "%ERRORLEVEL%"=="3010" EXIT 0)
RUN del /q vs_buildtools.exe

# Entry point that starts the developer command prompt and launches PowerShell.
# ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "-arch=amd64", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]

# WORKDIR makes directory if it doesn't exist
WORKDIR ${BUILD_DIR}

# Download and install Python
RUN curl %PYTHON_URL% -o python_installer.exe
RUN python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
RUN del /q python_installer.exe

# Install SCons
# Python/Pip behaves oddly here when run through the dockerfile, something to do with opening
# subprocesses with invalid file handled causes an error, failing the image build.
# Redirecting stdin to nul (windows equiv of /dev/null) seems to prevent the error.
RUN python -m pip install scons < nul
