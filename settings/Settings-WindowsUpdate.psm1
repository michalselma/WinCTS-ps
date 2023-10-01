########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

#### Advanced options - Updates for other Microsoft Products
# MS Update service behaviour can no longer be modified by registry edits alone. 
# Service modification requires register or unregister/remove the machine using the Windows Update Agent (WUA).
Function HKLM_UpdateOtherMsProducts-Disable {
	Write-Output "[DISABLE] CO_UpdateOtherMsProducts"
	Write-Output "[INFO] Settings | Windows Update | Advanced options | Receive updates for other Microsoft Products --> Disable"
	If ((New-Object -ComObject Microsoft.Update.ServiceManager).Services | Where-Object { $_.ServiceID -eq "7971f918-a847-4430-9279-4a52d1efe18d"}) {
		(New-Object -ComObject Microsoft.Update.ServiceManager).RemoveService("7971f918-a847-4430-9279-4a52d1efe18d")
		#(New-Object -com "Microsoft.Update.ServiceManager").RemoveService("7971f918-a847-4430-9279-4a52d1efe18d")
	}
	#Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services" -Name "DefaultService"
	#Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\7971F918-A847-4430-9279-4A52D1EFE18D" -Name "RegisteredWithAU" -Value 0
}
Function HKLM_UpdateOtherMsProducts-Enable {
	Write-Output "[ENABLE] CO_UpdateOtherMsProducts"
	Write-Output "[INFO] Settings | Windows Update | Advanced options | Receive updates for other Microsoft Products --> Enable"
	(New-Object -com "Microsoft.Update.ServiceManager").AddService2("7971f918-a847-4430-9279-4a52d1efe18d",7,"")
	#New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services" -Name "DefaultService" -Value 7971f918-a847-4430-9279-4a52d1efe18d
	#Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\7971F918-A847-4430-9279-4A52D1EFE18D" -Name "RegisteredWithAU" -Value 1
}

Export-ModuleMember -Function *