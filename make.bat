@echo off

FOR /F "tokens=* USEBACKQ" %%F IN (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -prerelease -products * -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe`) DO (
SET msbuild="%%F"
)
ECHO %msbuild%

rem dotnet build TrayRAMBooster.sln /t:Rebuild /p:DebugType=None /p:Configuration=Release
@%msbuild% TrayRAMBooster.sln /t:restore /p:RestorePackagesConfig=true /p:Configuration=Release /p:Platform="Any CPU"
if errorlevel 1 goto error
@%msbuild% TrayRAMBooster.sln /t:Rebuild /p:Configuration=Release /p:Platform="Any CPU"
if errorlevel 1 goto error

if [%1]==[all]  (

@%msbuild% TrayRAMBooster.sln /t:restore /p:RestorePackagesConfig=true /p:Configuration=Release /p:Platform="x64"
if errorlevel 1 goto error
@%msbuild% TrayRAMBooster.sln /t:Rebuild /p:Configuration=Release /p:Platform="x64"
if errorlevel 1 goto error

@%msbuild% TrayRAMBooster.sln /t:restore /p:RestorePackagesConfig=true /p:Configuration=Release /p:Platform="x86"
if errorlevel 1 goto error
@%msbuild% TrayRAMBooster.sln /t:Rebuild /p:Configuration=Release /p:Platform="x86"
if errorlevel 1 goto error
)

goto exit
:error
pause
:exit
