########################################
# Package: Change Windows Computer Name Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

# Check admin rights and if needed relaunch script with admin privileges 
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Write-Host "Script requires Administrator rights. Restarting..."
	Start-Process ComputerNameChange.cmd -Verb RunAs
	Exit
}
Write-Host "Script is run with Administrator rights."

$confirmRename = Read-Host "Do you want to change computer name ? (input 'y' or 'yes' and press ENTER to continue)"
if ((('y', 'yes') -contains $confirmRename)) {
	$computerName = Read-Host 'Enter New Computer Name'
	Write-Host "Changing Computer Name to: " $computerName
	Rename-Computer -NewName $computerName
} 
else {
	Write-Host "Undefined key pressed. Skipping Computer Rename."
}

# Ask to restart computer
$restart = Read-Host "Computer requires restart to appply changes. Input 'y' or 'yes' to restart computer now or ENTER to skip"
if ((('y', 'yes') -contains $restart)) {
	Write-Host "Restarting... "
	Restart-Computer
}
else {
	Write-Host "Skipping restart now. If any script changes were applied please restart your computer manually."
}