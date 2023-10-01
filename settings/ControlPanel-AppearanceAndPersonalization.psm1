########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 10
# Source Code: https://github.com/michalselma/WinCTS
########################################

#### File Explorer Options - Hide Protected operating system files
# **** This will only work when HKCU_ShowHiddenFilesAndFolders is enabled. Otherwise no effect.
# **** Also available thru: File Explorer\"..."\Options(Folder Options)\View\"Hide protected operating system files"
Function HKCU_ShowProtectedSystemFiles-Disable {
	Write-Output "[DISABLE] HKCU_ShowProtectedSystemFiles"
	Write-Output "[INFO] Control Panel | Appearance and Personalization | File Explorer Options | View | Hide protected operating system files --> Checked"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Type DWord -Value 0
}
Function HKCU_ShowProtectedSystemFiles-Enable {
	Write-Output "[ENABLE] HKCU_ShowProtectedSystemFiles"
	Write-Output "[INFO] Control Panel | Appearance and Personalization | File Explorer Options | View | Hide protected operating system files --> Unchecked"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Type DWord -Value 1
}

Export-ModuleMember -Function *