########################################
# Package: Windows Settings Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

# Check admin rights and if needed relaunch script with admin privileges 
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Write-Host "Script requires Administrator rights. Restarting..."
	Start-Process Settings.cmd -Verb RunAs
	Exit
}
Write-Host "Script is run with Administrator rights."

# Define config file location and name
$cfgfile = "$PSScriptRoot\config\settings.conf"

# Define log file location and name
$datetime = Get-Date -Format FileDateTime
$logfile = "$PSScriptRoot\log\$datetime-settings.log"

# Import script modules (functions)
$modules = Get-ChildItem -Recurse "$PSScriptRoot\settings\*.psm1" | Select-Object -ExpandProperty FullName
foreach ($module in $modules) {
	Import-Module -Name $module -ErrorAction Stop *>> $logfile
}

Write-Host "Processing settings configuration file..."
# Temporary variable to store config content
$cfgcontent = @()

# Read Config File
$cfgcontent = Get-Content $cfgfile -ErrorAction Stop

# Remove whitespaces at beggining and end of each object
$cfgcontent = $cfgcontent | ForEach-Object {$_.Trim()}

# Remove Empty lines/objects
$cfgcontent = $cfgcontent | Where-Object {$_}

# Remove comment lines from config file
$cfgcontent = $cfgcontent | Where-Object { $_.Substring(0,1) -ne '#'}

# Setting-up each option
foreach ($item in $cfgcontent) {
	# Split each object on '=' and build key & value pairs
	$item = $item.split("=")
	# Remove wihtespaces at beggining and end of each app after split
	$item = $item.trim()
	# Build key-value 'pairs' (not necessary - just to keep clear code)
	$key=$item[0]
	$value=$item[1]
	
	# Disable
	if ($value -eq 0) {
		$callfunction = "$key-Disable"
		Write-Host "Executing $callfunction"
		Invoke-Expression $callfunction *>> $logfile
	}
	# Enable
	elseif ($value -eq 1){
		$callfunction= "$key-Enable"
		Write-Host "Executing $callfunction"
		Invoke-Expression $callfunction *>> $logfile
	}
	# Skip
	elseif ($value -eq 2){
		Write-Host "Skipping $key modification."
		Write-Host "Skip -> $key" *>> $logfile
	}
	# Unknown
	else {
		Write-Host "*** $key - Incorrect or empty switch (='$value') in config file. Ignoring..."
		Write-Host "Error -> Unrecognized configuration switch for $key => '$value'" *>> $logfile
	}
}
# Restart explorer to apply changes
Write-Host "Restarting explorer to apply changes"
taskkill /f /im explorer.exe *>> $logfile
start explorer.exe *>> $logfile

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
