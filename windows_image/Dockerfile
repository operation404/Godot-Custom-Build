# escape=`

# Use the latest Windows Server Core 2019 image.
# My windows 10 machine is outdated and can't run the newest 2022 image.
FROM mcr.microsoft.com/windows/servercore:ltsc2019-amd64

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

ARG BUILD_DIR
ARG GIT_COMMIT
ARG DXC_LINK
ARG MESA_LINK
ARG PIX_LINK
ARG PYSTON_LINK

# Download the Build Tools bootstrapper.
RUN curl -SL --output vs_buildtools.exe https://aka.ms/vs/17/release/vs_buildtools.exe

# Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
RUN (start /w vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools" `
    --add Microsoft.VisualStudio.Workload.AzureBuildTools `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 `
    --remove Microsoft.VisualStudio.Component.Windows81SDK `
    || IF "%ERRORLEVEL%"=="3010" EXIT 0)
    
# Cleanup
RUN del /q vs_buildtools.exe

# Define the entry point for the docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
# ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "-arch=amd64", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]

# WORKDIR makes directory if it doesn't exist
WORKDIR ${BUILD_DIR}
ENV PY_VER=3.12.4
RUN curl https://www.python.org/ftp/python/${PY_VER}/python-${PY_VER}-amd64.exe -o python_installer.exe
RUN python_installer.exe /quiet InstallAllUsers=1
