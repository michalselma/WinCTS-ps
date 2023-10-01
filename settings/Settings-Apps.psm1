########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

#### Offline maps - Maps updates
Function HKLM_OfflineMapUpdates-Disable {
	Write-Output "[DISABLE] HKLM_OfflineMapUpdates"
	Write-Output "[INFO] Settings | Apps | Map updates | Update automatically when plugged in and on Wi-Fi --> Disable"
	Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
}
Function HKLM_OfflineMapUpdates-Enable {
	Write-Output "[ENABLE] HKLM_OfflineMapUpdates"
	Write-Output "[INFO] Settings | Apps | Map updates | Update automatically when plugged in and on Wi-Fi --> Enable"
	Remove-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled"
	#Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 1
}

# Export functions
Export-ModuleMember -Function *
