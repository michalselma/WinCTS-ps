########################################
# Package: Windows Power Options Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

# Check admin rights and if needed relaunch script with admin privileges 
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Write-Host "Script requires Administrator rights. Restarting..."
	Start-Process PowerOptions.cmd -Verb RunAs
	Exit
}
Write-Host "Script is run with Administrator rights."

# Get full path/directory of the script that is being run
$varScriptDir = $PSScriptRoot

Write-Host "Choose power options preset type"
Write-Host "1 - Desktop"
Write-Host "2 - Laptop"
$configtype = Read-Host "Input preset value and press Enter"
if ((('1') -contains $configtype)) {
	# Config File Location - Desktop
	$presetpath = "$varScriptDir\config\poweroptions-desktop.conf"
}
elseif ((('2') -contains $configtype)) {
	# Config File Location - Laptop
	$presetpath = "$varScriptDir\config\poweroptions-laptop.conf"
}
else {
	Write-Host "Incorrect preset value. Stopping script."
	Exit
}

# Read Config File
$pwrsettings = Get-Content $presetpath -ErrorAction Stop

# Remove whitespaces at beggining and end of each object
$pwrsettings = $pwrsettings | ForEach-Object {$_.Trim()}

# Remove Empty lines/objects
$pwrsettings = $pwrsettings | Where-Object {$_}

# Remove comment lines from config file
$pwrsettings = $pwrsettings | Where-Object { $_.Substring(0,1) -ne '#'}

# Setting-up each option
foreach ($object in $pwrsettings) {
	# Split each object on '.' (config type) and '=' (key & value)
	$object = $object.split(".").split("=")
	# Remove wihtespaces at beggining and end of each (sub)object after split
	$object = $object.trim()
	# Build type-key-value 'pairs' (not necessary - just to keep clear code)
	$type=$object[0]
	$key=$object[1]
	$value=$object[2]
	# Execute Windows CMD 'powercfg.exe' specific command / option per key-value type (change, set value index for SUB_BUTTON / SUB_BATTERY or other command )
	if ($type -eq "CHANGE") {
		powercfg /change $key $value
	}
	elseif($type -eq "SBUTTON_setDC") {
		powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS $key $value
	}
	elseif($type -eq "SBUTTON_setAC") {
		powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS $key $value
	}
	elseif($type -eq "SBATTERY_setDC") {
		powercfg /setdcvalueindex SCHEME_CURRENT SUB_BATTERY $key $value
	}
	elseif($type -eq "SBATTERY_setAC") {
		powercfg /setacvalueindex SCHEME_CURRENT SUB_BATTERY $key $value
	}
	elseif($type -eq "OTHER") {
		powercfg /$key $value
	}
	else {
		Write-Host "Error. Incorrect configuration item: $object"
	}
}

Write-Host "Script finished."