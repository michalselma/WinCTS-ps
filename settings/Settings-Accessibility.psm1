########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

#### Interaction - Keyboard - Sticky keys
Function HKCU_StickyKeysShortcutKey-Disable {
	Write-Output "[DISABLE] HKCU_StickyKeysShortcutKey"
	Write-Output "[INFO] Settings | Accessibility | Interaction | Keybord | Sticky keys --> Disable"
	Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "510"
}
Function HKCU_StickyKeysShortcutKey-Enable {
	Write-Output "[ENABLE] HKCU_StickyKeysShortcutKey"
	Write-Output "[INFO] Settings | Accessibility | Interaction | Keybord | Sticky keys --> Enable"
	Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "511"
}

#### Interaction - Keyboard - Filter keys
Function HKCU_FilterKeysShortcutKey-Disable {
	Write-Output "[DISABLE] HKCU_FilterKeysShortcutKey"
	Write-Output "[INFO] Settings | Accessibility | Interaction | Keybord | Filter keys --> Disable"
	Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -Type String -Value "126"
}
Function HKCU_FilterKeysShortcutKey-Enable {
	Write-Output "[ENABLE] HKCU_FilterKeysShortcutKey"
	Write-Output "[INFO] Settings | Accessibility | Interaction | Keybord | Filter keys --> Enable"
	Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -Type String -Value "127"
}

#### Interaction - Keyboard - Toggle keys
Function HKCU_ToggleKeysShortcutKey-Disable {
	Write-Output "[DISABLE] HKCU_ToggleKeysShortcutKey"
	Write-Output "[INFO] Settings | Accessibility | Interaction | Keybord | Toggle keys --> Disable"
	Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Type String -Value "62"
}
Function HKCU_ToggleKeysShortcutKey-Enable {
	Write-Output "[ENABLE] HKCU_ToggleKeysShortcutKey"
	Write-Output "[INFO] Settings | Accessibility | Interaction | Keybord | Toggle keys --> Enable"
	Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Type String -Value "63"
}

Export-ModuleMember -Function *