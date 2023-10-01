########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 10
# Source Code: https://github.com/michalselma/WinCTS
########################################

#### Windows Search indexing service
Function WinSearchIndexing-Disable {
	Write-Output "Disable and stop -> [Services] -> Windows Search indexing service"
	Stop-Service "WSearch" -WarningAction SilentlyContinue
	Set-Service "WSearch" -StartupType Disabled
}
Function WinSearchIndexing-Enable {
	Write-Output "Enable and start -> [Services] -> Windows Search indexing service"
	Set-Service "WSearch" -StartupType Automatic
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WSearch" -Name "DelayedAutoStart" -Type DWord -Value 1
	Start-Service "WSearch" -WarningAction SilentlyContinue
}

#### Stop and disable Device Management Wireless Application Protocol (WAP) Push Service
# Note: This service is needed for Microsoft Intune interoperability
Function WAPPush-Disable {
	Write-Output "Disable and stop -> [Services] -> Device Management Wireless Application Protocol (WAP) Push Service"
	Stop-Service "dmwappushservice" -WarningAction SilentlyContinue
	Set-Service "dmwappushservice" -StartupType Disabled
}
Function WAPPush-Enable {
	Write-Output "Enable and start -> [Services] -> Device Management Wireless Application Protocol (WAP) Push Service"
	Set-Service "dmwappushservice" -StartupType Automatic
	Start-Service "dmwappushservice" -WarningAction SilentlyContinue
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\dmwappushservice" -Name "DelayedAutoStart" -Type DWord -Value 1
}

#### Stop and disable Connected User Experiences and Telemetry (previously named Diagnostics Tracking Service)
Function DiagTrack-Disable {
	Write-Output "Disable and stop -> [Services] -> Diagnostics Tracking Service (Connected User Experiences and Telemetry)"
	Stop-Service "DiagTrack" -WarningAction SilentlyContinue
	Set-Service "DiagTrack" -StartupType Disabled
}
Function DiagTrack-Enable {
	Write-Output "Enable and start -> [Services] -> Diagnostics Tracking Service (Connected User Experiences and Telemetry)"
	Set-Service "DiagTrack" -StartupType Automatic
	Start-Service "DiagTrack" -WarningAction SilentlyContinue
}