########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

#### Notifications - Additional settings - Welcome Experience
Function HKCU_WindowsWelcomeExperience-Disable {
	Write-Output "[DISABLE] HKCU_WindowsWelcomeExperience"
	Write-Output "[INFO] Settings | System | Notifications | Additional settings | Show the Windows welcome experience --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 0
}
Function HKCU_WindowsWelcomeExperience-Enable {
	Write-Output "[ENABLE] HKCU_WindowsWelcomeExperience"
	Write-Output "[INFO] Settings | System | Notifications | Additional settings | Show the Windows welcome experience --> Enable"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled"
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 1
}

#### Notifications - Additional settings - Most Out Of Windows
Function HKCU_MostOutOfWindows-Disable {
	Write-Output "[DISABLE] HKCU_MostOutOfWindows"
	Write-Output "[INFO] Settings | System | Notifications | Additional settings | Suggest ways to get the most out of Windows --> Disable"
	If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Force
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Type DWord -Value 0
}
Function HKCU_MostOutOfWindows-Enable {
	Write-Output "[ENABLE] HKCU_WindowsWelcomeExperience"
	Write-Output "[INFO] Settings | System | Notifications | Additional settings | Suggest ways to get the most out of Windows --> Enable"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled"
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Type DWord -Value 1
	
}

#### Notifications - Additional settings - Tips And Suggestions
Function HKCU_TipsAndSuggestions-Disable {
	Write-Output "[DISABLE] HKCU_TipsAndSuggestions"
	Write-Output "[INFO] Settings | System | Notifications | Additional settings | Get tips and suggestions when using Windows --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
}
Function HKCU_TipsAndSuggestions-Enable {
	Write-Output "[ENABLE] HKCU_WindowsWelcomeExperience"
	Write-Output "[INFO] Settings | System | Notifications | Additional settings | Get tips and suggestions when using Windows --> Enable"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled"
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 1
}

#### About - Advanced system settings - Remote - Remote Assistance
# 'Get-WindowsCapability -Online' command is addon that removes Quick Assist application
Function HKLM_RemoteAssistance-Disable {
	Write-Output "[DISABLE] HKLM_RemoteAssistance"
	Write-Output "[INFO] Settings | System | About | Advanced system settings | Remote | Remote Assistance --> Disable"
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowFullControl" -Type DWord -Value 0
	netsh advfirewall firewall set rule group="Remote Assistance" new enable=no
	Get-WindowsCapability -Online | Where-Object { $_.Name -like "App.Support.QuickAssist*" } | Remove-WindowsCapability -Online
}
Function HKLM_RemoteAssistance-Enable {
	Write-Output "[ENABLE] HKLM_RemoteAssistance"
	Write-Output "[INFO] Settings | System | About | Advanced system settings | Remote | Remote Assistance --> Enable"
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 1
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowFullControl" -Type DWord -Value 1
	netsh advfirewall firewall set rule group="Remote Assistance" new enable=yes
	Get-WindowsCapability -Online | Where-Object { $_.Name -like "App.Support.QuickAssist*" } | Add-WindowsCapability -Online
}

Export-ModuleMember -Function *