########################################
# Package: Windows Appx Packages Modification Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

# Check admin rights and if needed relaunch script with admin privileges 
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Write-Host "Script requires Administrator rights. Restarting..."
	Start-Process AppxPackages.cmd -Verb RunAs
	Exit
}
Write-Host "Script is run with Administrator rights."

# Define config file location and name
$cfgfile = "$PSScriptRoot\config\appxpackages.conf"

# Define log file location and name
$datetime = Get-Date -Format FileDateTime
$logfile = "$PSScriptRoot\log\$datetime-appxpackages.log"

# Import script modules (functions)
Import-Module -Name "$PSScriptRoot\AppxPackages.psm1" -ErrorAction Stop *>> $logfile

# Get list of installed applications/packages for reference/comaprision purpose
Write-Host "[INFO] Installed appx packages [before snapshot]:" *>> $logfile
Get-AppxPackage -AllUsers | Format-Table -Property Name *>> $logfile

Write-Host "Starting Applications installation/uninstallation module."

$removeapps, $addapps, $skipapps = ProcessAppxConfig($cfgfile)
Write-Host "Config file:" ($removeapps.length) "items for uninstallation."
Write-Host "Config file:" ($addapps.length) "items for installation/reinstallation."
Write-Host "Config file:" ($skipapps.length) "items to be skipped."

if (($removeapps.length) -eq 0){
	Write-Host "Nothing to be uninstalled."
}
else {
	Write-Host "Please choose uninstalltion/removal option:"
	Write-Host "1 - Current user uninstallation"
	Write-Host "2 - All existing users uninstallation"
	Write-Host "3 - Permanent Removal for all existing and future users"
	$removaloption = Read-Host "Input '1', '2' or '3' to continue or ENTER to cancel)"
	if ((('1') -contains $removaloption)) {
		UninstallAppx_currentuser($removeapps) *>> $logfile
	}
	elseif ((('2') -contains $removaloption)) {
		UninstallAppx_currentuser($removeapps) *>> $logfile
		UninstallAppx_allusers($removeapps) *>> $logfile
	}
	elseif ((('3') -contains $removaloption)) {
		UninstallAppx_currentuser($removeapps) *>> $logfile
		UninstallAppx_allusers($removeapps) *>> $logfile
		RemoveAppx_SysProvisioned($removeapps) *>> $logfile
	}
	else {
		Write-Host "Uninstall/Removal cancelled..." 
		Write-Host "[INFO] Uninstall/Removal cancelled..." *>> $logfile
	}
}

if (($addapps.length) -eq 0){
	Write-Host "Nothing awaiting installation."
	Write-Host "[INFO] Nothing awaiting installation." *>> $logfile
}
else {
	InstallAppx_currentuser($addapps) *>> $logfile
}

Write-Host "Finished Applications installation/uninstallation module."

# Get list of installed applications/packages for reference/comaprision purpose
Write-Host "[INFO] Installed appx packages [after snapshot]:" *>> $logfile
Get-AppxPackage -AllUsers | Format-Table -Property Name *>> $logfile

Write-Host "Script finished."

# Ask to restart computer
$restart = Read-Host "Computer requires restart to appply changes. Input 'y' or 'yes' to restart computer now or ENTER to skip"
if ((('y', 'yes') -contains $restart)) {
	Write-Host "Restarting... "
	Restart-Computer
}
else {
	Write-Host "Skipping restart now. If any script changes were applied please restart your computer manually."
}
