########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################


#### Start - Layout
#### ***** To be implemented
#[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced] "Start_Layout"=dword:00000001


#### Start - Recently Added Apps
Function HKCU_ShowRecentlyAddedApps-Disable {
	Write-Output "[DISABLE] HKCU_ShowRecentlyAddedApps"
	Write-Output "[INFO] Settings | Personalization | Start | Show recently added apps --> Disable"
	Write-Output "*** NOT IMPLEMENTED YET ***"
}
Function HKCU_ShowRecentlyAddedApps-Enable {
	Write-Output "[ENABLE] HKCU_ShowRecentlyAddedApps"
	Write-Output "[INFO] Settings | Personalization | Start | Show recently added apps --> Enable"
	Write-Output "*** NOT IMPLEMENTED YET ***"
}

#### Start - Show the most used apps
# **** This option can be "grey out" by disabling "Settings | Privacy & security | Windows permissions | General | Let Windows improve Start and search results by tracking app launches"
Function HKCU_ShowMostUsedApps-Disable {
	Write-Output "[DISABLE] HKCU_ShowMostUsedApps"
	Write-Output "[INFO] Settings | Personalization | Start | Show the most used apps --> Disable"
	Write-Output "*** NOT IMPLEMENTED YET ***"
}
Function HKCU_ShowMostUsedApps-Enable {
	Write-Output "[ENABLE] HKCU_ShowMostUsedApps"
	Write-Output "[INFO] Settings | Personalization | Start | Show the most used apps --> Enable"
	Write-Output "*** NOT IMPLEMENTED YET ***"
}

#### Start - Show recently opened items
# Recent items and frequent places are stored in the folder locations below.
# %APPDATA%\Microsoft\Windows\Recent Items
# %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations
# %APPDATA%\Microsoft\Windows\Recent\CustomDestinations
# c:\Users\xxxxx\AppData\Roaming\Microsoft\Windows\Recent\
# c:\Users\xxxxx\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations
# c:\Users\xxxxx\AppData\Roaming\Microsoft\Windows\Recent\CustomDestinations
# TO DO: Add cleanup activity of above locations
Function HKCU_ShowRecentlyOpenedItems-Disable {
	Write-Output "[DISABLE] HKCU_ShowRecentlyOpenedItems"
	Write-Output "[INFO] Settings | Personalization | Start | Show recently opened items in Start, Jump Lists, and File Explorer --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Type DWord -Value 0
}
Function HKCU_ShowRecentlyOpenedItems-Enable {
	Write-Output "[ENABLE] HKCU_ShowRecentlyOpenedItems"
	Write-Output "[INFO] Settings | Personalization | Start | Show recently opened items in Start, Jump Lists, and File Explorer --> Enable"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs"
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Type DWord -Value 1
}
Function HKLM_ShowRecentlyOpenedItems-Disable {
	Write-Output "[DISABLE] HKLM_ShowRecentlyOpenedItems"
	Write-Output "[INFO] Local Machine Policy | Start:Show recently opened items in Start, Jump Lists, and File Explorer --> Disable"
	If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -Type DWord -Value 1
}
Function HKLM_ShowRecentlyOpenedItems-Enable {
	Write-Output "[ENABLE] HKLM_ShowRecentlyOpenedItems"
	Write-Output "[INFO] Local Machine Policy | Start:Show recently opened items in Start, Jump Lists, and File Explorer --> Enable"
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory"
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory"
}

#### Taskbar - Show Search
Function HKCU_ShowSearch-Disable {
	Write-Output "[DISABLE] HKCU_ShowSearch"
	Write-Output "[INFO] Settings | Personalization | Taskbar | Taskbar items | Search --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
}
Function HKCU_ShowSearch-Enable {
	Write-Output "[ENABLE] HKCU_ShowSearch"
	Write-Output "[INFO] Settings | Personalization | Taskbar | Taskbar items | Search --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 1
}

#### Taskbar - Show Task view
Function HKCU_ShowTaskView-Disable {
	Write-Output "[DISABLE] HKCU_ShowTaskView"
	Write-Output "[INFO] Settings | Personalization | Taskbar | Taskbar items | Task view --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
}
Function HKCU_ShowTaskView-Enable {
	Write-Output "[ENABLE] HKCU_ShowTaskView"
	Write-Output "[INFO] Settings | Personalization | Taskbar | Taskbar items | Task view --> Enable"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton"
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 1
}
Function HKLM_ShowTaskView-Disable {
	Write-Output "[DISABLE] HKLM_ShowTaskView"
	Write-Output "[INFO] Local Machine Policy | Taskbar:Task view --> Disable"
	If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideTaskViewButton" -Type DWord -Value 1
}
Function HKLM_ShowTaskView-Enable {
	Write-Output "[ENABLE] HKLM_ShowTaskView"
	Write-Output "[INFO] Local Machine Policy | Taskbar:Task view --> Enable"
	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideTaskViewButton"
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideTaskViewButton"
}

#### Taskbar - Show Widgets
Function HKCU_ShowWidgets-Disable {
	Write-Output "[DISABLE] HKCU_ShowWidgets"
	Write-Output "[INFO] Settings | Personalization | Taskbar | Taskbar items | Widgets --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Type DWord -Value 0
}
Function HKCU_ShowWidgets-Enable {
	Write-Output "[ENABLE] HKCU_ShowWidgets"
	Write-Output "[INFO] Settings | Personalization | Taskbar | Taskbar items | Widgets --> Enable"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa"
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Type DWord -Value 1
}

#### Taskbar - Show Chat
Function HKCU_ShowChat-Disable {
	Write-Output "[DISABLE] HKCU_ShowChat"
	Write-Output "[INFO] Settings | Personalization | Taskbar | Taskbar items | Chat --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Type DWord -Value 0
}
Function HKCU_ShowChat-Enable {
	Write-Output "[ENABLE] HKCU_ShowChat"
	Write-Output "[INFO] Settings | Personalization | Taskbar | Taskbar items | Chat --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Type DWord -Value 1
}

#### Taskbar - Taskbar alignment centre/left
Function HKCU_TaskbarAlignmentLeft-Disable {
	Write-Output "[DISABLE] HKCU_TaskbarAlignmentLeft"
	Write-Output "[INFO] Settings | Personalization | Taskbar | Taskbar behaviours | Taskbar alignment --> Centre (Default)"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl"
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Type DWord -Value 1
}
Function HKCU_TaskbarAlignmentLeft-Enable {
	Write-Output "[ENABLE] HKCU_TaskbarAlignmentLeft"
	Write-Output "[INFO] Settings | Personalization | Taskbar | Taskbar behaviours | Taskbar alignment --> Left"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Type DWord -Value 0
}

Export-ModuleMember -Function *