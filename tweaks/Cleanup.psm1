########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

# Unpin all Start Menu tiles
Function UnpinStartMenuTiles-Enable {
	'[INFO] Executing: {0}' -f $MyInvocation.MyCommand
	Write-Output "[INFO] Unpinning all Start Menu tiles..."
	If ([System.Environment]::OSVersion.Version.Build -ge 15063 -And [System.Environment]::OSVersion.Version.Build -le 16299) {
		Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount" -Include "*.group" -Recurse | ForEach-Object {
			$data = (Get-ItemProperty -Path "$($_.PsPath)\Current" -Name "Data").Data -Join ","
			$data = $data.Substring(0, $data.IndexOf(",0,202,30") + 9) + ",0,202,80,0,0"
			Set-ItemProperty -Path "$($_.PsPath)\Current" -Name "Data" -Type Binary -Value $data.Split(",")
		}
	} ElseIf ([System.Environment]::OSVersion.Version.Build -ge 17134) {
		$key = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\*start.tilegrid`$windows.data.curatedtilecollection.tilecollection\Current"
		$data = $key.Data[0..25] + ([byte[]](202,50,0,226,44,1,1,0,0))
		Set-ItemProperty -Path $key.PSPath -Name "Data" -Type Binary -Value $data
		Stop-Process -Name "ShellExperienceHost" -Force -ErrorAction SilentlyContinue
	}
}
Function UnpinStartMenuTiles-Disable {
	'[INFO] Executing: {0}' -f $MyInvocation.MyCommand
	Write-Output "[INFO] No action"
}

# Unpin all Taskbar icons
Function UnpinTaskbarIcons-Enable {
	'[INFO] Executing: {0}' -f $MyInvocation.MyCommand
	Write-Output "[INFO] Unpinning all Taskbar icons..."
	If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Force
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "Favorites" -Type Binary -Value ([byte[]](255))
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "FavoritesResolve"
	#Below are alternatives found for Windows 11 - Taskband key content to be checked on clean install, DEL might require modification for powershell
	#DEL /F /S /Q /A "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*"
	#REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband\ /v FavoritesRemovedChanges /f
}
Function UnpinTaskbarIcons-Disable {
	'[INFO] Executing: {0}' -f $MyInvocation.MyCommand
	Write-Output "[INFO] No action"
}

# Export functions
Export-ModuleMember -Function *