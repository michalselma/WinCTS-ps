########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 10
# Source Code: https://github.com/michalselma/WinCTS
########################################

#### UWP swapfile.sys
# Partially related to "System -> About -> Advanced System Settings -> Advanced -> Performence -> Advanced -> Virtual Memory"
# swapfile.sys is special type of pagefile.sys used to Suspend or Resume UWP Windows apps. 
# When Virtual Memory paging is turned off this file will be turned off as well. 
# This tweak will turn off swapfile.sys ONLY without turning off pagefile.sys ("no effect on the real swap in pagefile.sys").
Function UWPSwapFile-Disable {
	Write-Output "Disable -> System Settings -> Performence -> Advanced -> Virtual Memory -> swapfile.sys"
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "SwapfileControl" -Type Dword -Value 0
}
Function UWPSwapFile-Enable {
	Write-Output "Enable -> Advanced System Settings -> Performence -> Advanced -> Virtual Memory -> swapfile.sys"
	Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "SwapfileControl"
}

# Export functions
Export-ModuleMember -Function *
