########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

#### Cortana
Function Cortana-Disable {
	Write-Output "Disable -> Cortana"
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" -Name "Value" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Force
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Name "AllowInputPersonalization" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0
}
Function Cortana-Enable {
	Write-Output "Enable -> Cortana"
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 1
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" -Name "Value" -Type DWord -Value 1
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana"
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Name "AllowInputPersonalization"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 1
}

#### OneDrive
Function OneDrive-Disable {
	Write-Output "[REMOVE] --> OneDrive"
	# **** OneDrive process stop ****
	TASKKILL /f /im OneDrive.exe
	# **** OneDrive Uninstall ****
	set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
	set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
	If (exist %x64%) {
		%x64% /uninstall
	}
	Else {
		%x86% /uninstall
	}
	# **** OneDrive Folders Cleanup ****
	rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
	rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
	rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
	rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1
	# **** OneDrive in Explorer Side Panel Removal ****
	REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
	REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
	# **** Turn off OneDrive syncing ****
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1
	# Turn off OneDrive to start at startup
	#https://www.elevenforum.com/t/turn-on-or-off-onedrive-run-at-startup-in-windows-11.2321/
	# Turn off OneDrive Paused Syncing Notification
	#https://www.elevenforum.com/t/enable-or-disable-notifications-when-onedrive-syncing-is-paused-in-windows-11.10911/
}
Function OneDrive-Enable {
	Write-Output "Enable -> OneDrive"
	# *** NOT IMPLEMENTED YET ***
}

# Export functions
Export-ModuleMember -Function *
