########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 10
# Source Code: https://github.com/michalselma/WinCTS
########################################

#### To get rid of all group or local policies applied by gpupdate remove the following reg keys (seems to be rather safe):
# reg delete "HKCU\Software\Policies\Microsoft" /f
# reg delete "HKLM\Software\Policies\Microsoft" /f
# reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies" /f
# reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies" /f
#### Below are probably definitions of GPO (be careful when removing)
# reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy" /f
# reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy" /f
#### Enter the following command to see which policies are applied:
# For computer policies:
# gpresult /Scope Computer /v
# For user policies:
# gpresult /Scope User /v
#### Group Policy scripts downloaded from AD are located here and can be removed:
# RD /S /Q "%WinDir%\System32\GroupPolicy"
# RD /S /Q "%WinDir%\System32\GroupPolicyUsers"
# gpupdate.exe /force <- This will fail incase of lack of AD connection (when trinign to refresh after GPO scripts removal)

#### Windows Update Group Policy control
Function WUPolicyControl-Disable {
	Write-Output "Disable -> Windows Update Group Policy control"
	Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Recurse
	Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Recurse
}
Function WUPolicyControl-Enable {
	Write-Output "Enable -> Windows Update Group Policy control"
	Write-Output "To Enable Group Policy Control over Windows Update run your Group Policy refresh when connected to corporate network ('gpupdate /force' CMD command)"
}

# Export functions
Export-ModuleMember -Function *