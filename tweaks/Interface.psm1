########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

#### Windows build number and Windows edition (Home/Pro/Enterprise) at bottom right of desktop
Function HKCU_BuildNumberOnDesktop-Disable {
	'[INFO] Executing: {0}' -f $MyInvocation.MyCommand
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "PaintDesktopVersion" -Type DWord -Value 0
}
Function HKCU_BuildNumberOnDesktop-Enable {
	'[INFO] Executing: {0}' -f $MyInvocation.MyCommand 
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "PaintDesktopVersion" -Type DWord -Value 1
}

#### Web Search Results for Start Menu / Taskbar Search
Function HKCU_WebSearchForTaskbarSearch-Disable {
	'[INFO] Executing: {0}' -f $MyInvocation.MyCommand
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0
}
Function HKCU_WebSearchForTaskbarSearch-Enable {
	'[INFO] Executing: {0}' -f $MyInvocation.MyCommand
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 1
}

Function HKCU_Policy_WebSearchSuggestionForSearchBox-Disable {
	'[INFO] Executing: {0}' -f $MyInvocation.MyCommand
	If (!(Test-Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer")) {
		New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Force
	}
	Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Type DWord -Value 1
}
Function HKCU_Policy_WebSearchSuggestionForSearchBox-Enable {
	'[INFO] Executing: {0}' -f $MyInvocation.MyCommand
	Remove-ItemProperty  -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions"
}

#### Taskbar - Small taskbar icons
### Win 11 is hidden and size but "old" registry exists-> https://www.elevenforum.com/t/change-size-of-taskbar-icons-in-windows-11.45/
Function HKCU_TaskbarSmallIcons-Disable {
	Write-Output "[DISABLE] HKCU_TaskbarSmallIcons"
	Write-Output "[INFO] Settings | Personalization | Taskbar |  --> Enable"
	Write-Output "Disable -> [Settings | Personalization] -> Taskbar | Use small taskbar buttons"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons"
}
Function HKCU_TaskbarSmallIcons-Enable {
	Write-Output "[ENABLE] HKCU_TaskbarSmallIcons"
	Write-Output "Enable -> [Settings | Personalization] -> Taskbar | Use small taskbar buttons"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" -Type DWord -Value 1
}

#### Taskbar - Always Show all icons in taskbar
Function ShowAllTrayIcons-Disable {
	Write-Output "Disable -> [Settings | Personalization] -> Taskbar | Notification area | Select which icons appear on the taskbar | Always show all icons in the notification area"	
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray"
}
Function ShowAllTrayIcons-Enable {
	Write-Output "Enable -> [Settings | Personalization] -> Taskbar | Notification area | Select which icons appear on the taskbar | Always show all icons in the notification area"
	If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 1
	# Experimental
	If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoTrayItemsDisplay" -Type DWord -Value 1
}

#### Taskbar - People icon
# Also configurable via [Taskbar | 'Right Click'] -> Show People on the taskbar
Function PeopleIcon-Disable {
	Write-Output "Disable -> [Settings | Personalization] -> Taskbar | People | Show contacts on the taskbar"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand"
}
Function PeopleIcon-Enable {
	Write-Output "Enable -> [Settings | Personalization] -> Taskbar | People | Show contacts on the taskbar"
	Write-Output "Enable -> [Taskbar | 'Right Click'] -> Show People on the taskbar"
	If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 1
}

# Export functions
Export-ModuleMember -Function *