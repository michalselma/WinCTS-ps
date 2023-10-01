########################################
# Package: Windows Tweaks Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

#### For developers - File Explorer file extensions
# **** Also available thru: 
# **** (1) Control Panel\Appearance and Personalisation\File Explorer Options\View\"Hide extensions for known file types"
# **** (2) File Explorer\"..."\Options(Folder Options)\View\"Hide extensions for known file types"
Function HKCU_ShowFileExtensions-Disable {
	Write-Output "[DISABLE] HKCU_ShowFileExtensions"
	Write-Output "[INFO] Settings | Privacy & security | Security | For developers | File Explorer | Show file extensions --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 1
}
Function HKCU_ShowFileExtensions-Enable {
	Write-Output "[ENABLE] HKCU_ShowFileExtensions"
	Write-Output "[INFO] Settings | Privacy & security | Security | For developers | File Explorer | Show file extensions --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0
}

#### For developers - File Explorer hidden and system files
# **** (1) Control Panel\Appearance and Personalisation\File Explorer Options\View\"Hidden files and folders"
# **** (2) File Explorer\"..."\Options(Folder Options)\View\"Hidden files and folders"
Function HKCU_ShowHiddenFilesAndFolders-Disable {
	Write-Output "[DISABLE] HKCU_ShowHiddenFilesAndFolders"
	Write-Output "[INFO] Settings | Privacy & security | Security | For developers | File Explorer | Show hidden and system files --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 2
}	
Function HKCU_ShowHiddenFilesAndFolders-Enable {
	Write-Output "[ENABLE] HKCU_ShowHiddenFilesAndFolders"
	Write-Output "[INFO] Settings | Privacy & security | Security | For developers | File Explorer | Show hidden and system files --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 1
}

#### General - AdvertisingID
Function HKCU_AdvertisingID-Disable {
	Write-Output "[DISABLE] HKCU_AdvertisingID"
	Write-Output "[INFO] Settings | Privacy & security | Windows permissions | General | Let apps show me personalised ads by using my advertising ID --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Type DWord -Value 0
}
Function HKCU_AdvertisingID-Enable {
	Write-Output "[ENABLE] HKCU_AdvertisingID"
	Write-Output "[INFO] Settings | Privacy & security | Windows permissions | General | Let apps show me personalised ads by using my advertising ID --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Type DWord -Value 1
}

#### General - Website access to language list
Function HKCU_WebAccessToLangList-Disable {
	Write-Output "[DISABLE] HKCU_WebAccessToLangList"
	Write-Output "[INFO] Settings | Privacy & security | Windows permissions | General | Let websites show me locally relevant content by accessing my language list --> Disable"
	Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 1
}
Function HKCU_WebAccessToLangList-Enable {
	Write-Output "[ENABLE] HKCU_WebAccessToLangList"
	Write-Output "[INFO] Settings | Privacy & security | Windows permissions | General | Let websites show me locally relevant content by accessing my language list --> Enable"
	Remove-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut"
	#Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 0
}

#### General - Track app launches
# **** Disabling this option will "grey out" "Settings | Personalization | Start | Show the most used apps" option
Function HKCU_LetTrackAppLaunches-Disable {
	Write-Output "[DISABLE] HKCU_LetTrackAppLaunches"
	Write-Output "[INFO] Settings | Privacy & security | Windows permissions | General | Let Windows improve Start and search results by tracking app launches --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Type DWord -Value 0
}
Function HKCU_LetTrackAppLaunches-Enable {
	Write-Output "[ENABLE] HKCU_LetTrackAppLaunches"
	Write-Output "[INFO] Settings | Privacy & security | Windows permissions | General | Let Windows improve Start and search results by tracking app launches --> Enable"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs"
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Type DWord -Value 1
}

#### General - Show me suggested content in the Settings app
Function HKCU_SuggestedContentInSettings-Disable {
	Write-Output "[DISABLE] HKCU_SuggestedContentInSettings"
	Write-Output "[INFO] Settings | Privacy & security | Windows permissions | General | Show me suggested content in the Settings app --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Type DWord -Value 0
}
Function HKCU_SuggestedContentInSettings-Enable {
	Write-Output "[ENABLE] HKCU_SuggestedContentInSettings"
	Write-Output "[INFO] Settings | Privacy & security | Windows permissions | General | Show me suggested content in the Settings app --> Enable"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled"
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" 
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 1
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Type DWord -Value 1
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Type DWord -Value 1
}

#### Speach - Online speach recognition
#### **** TO DO

#### Inking & typing personalisation - Personal inking and typing dictonary
Function HKCU_InkingAndTypingPersonalisation-Disable {
	Write-Output "[DISABLE] HKCU_InkingAndTypingPersonalisation"
	Write-Output "[INFO] Settings | Privacy & security | Windows permissions | Inking & typing personalisation | Customised inking and typing dictionary --> Disable"
	If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\InkingAndTypingPersonalization")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\InkingAndTypingPersonalization" -Force
	}	
	Set-ItemProperty  -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\InkingAndTypingPersonalization" -Name "Value" -Type DWord -Value 0
	If (!(Test-Path "HKCU:\Software\Microsoft\Personalization\Settings")) {
		New-Item -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Force
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
	If (!(Test-Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore")) {
		New-Item -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Force
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
}
Function HKCU_InkingAndTypingPersonalisation-Enable {
	Write-Output "[ENABLE] HKCU_InkingAndTypingPersonalisation"
	Write-Output "[INFO] Settings | Privacy & security | Windows permissions | Inking & typing personalisation | Customised inking and typing dictionary --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\InkingAndTypingPersonalization" -Name "Value" -Type DWord -Value 1
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy"
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 0
	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts"
	#Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 1
}

#### Diagnostics & feedback - Diagnostic data / Send optional diagnstic data
#### **** TO DO

#### Diagnostics & feedback - Tailored experiences
Function HKCU_TailoredExperiences-Disable {
	Write-Output "[DISABLE] HKCU_TailoredExperiences"
	Write-Output "[INFO] Settings | Privacy & security | Windows permissions | Diagnostics & feedback | Tailored experiences --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Type DWord -Value 0
}
Function HKCU_TailoredExperiences-Enable {
	Write-Output "[ENABLE] HKCU_TailoredExperiences"
	Write-Output "[INFO] Settings | Privacy & security | Windows permissions | Diagnostics & feedback | Tailored experiences --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Type DWord -Value 1
}

#### Diagnostics & feedback - Delete diagnostic data
#### **** TO DO

#### Diagnostics & feedback - Feedback/Feedback frequency
#### **** TO DO

#### Activity history - Activity history/Store my activity history on this device
#### **** TO DO

#### Activity history - Activity history/Send my activity history to Microsoft
#### **** TO DO

#### Activity history - Clear activity history for this account
#### **** TO DO

#### Search Permissions - ...
#### **** TO DO

#### Searching Windows - Indexing
#### **** TO DO


# TODO: Regs to be checked:
# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity]
# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetooth]
# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData]
# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\gazeInput]
# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\humanInterfaceDevice]
# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sensors.custom]
# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\serialCommunication]
# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\usb]
# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wifiData]
# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wiFiDirect]
# and their counterparts in HKEY_CURRENT_USER

#### Location
Function HKCU_Location-Disable {
	Write-Output "[DISABLE] HKCU_Location"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Location | Let apps access your location --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Location | Let desktop apps access your location --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location\NonPackaged" -Name "Value" -Value "Deny"
}
Function HKCU_Location-Enable {
	Write-Output "[ENABLE] HKCU_Location"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Location | Let apps access your location --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Allow"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Location | Let desktop apps access your location --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location\NonPackaged" -Name "Value" -Value "Allow"
}
Function HKLM_Location-Disable {
	Write-Output "[DISABLE] HKLM_Location"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Location | Location services --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny"
}
Function HKLM_Location-Enable {
	Write-Output "[ENABLE] HKLM_Location"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Location | Location services --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Allow"
}

#### Camera
Function HKCU_Camera-Disable {
	Write-Output "[DISABLE] HKCU_Camera"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Camera | Let apps access your camera --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -Value "Deny"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Camera | Let desktop apps access your camera --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam\NonPackaged" -Name "Value" -Value "Deny"
}
Function HKCU_Camera-Enable {
	Write-Output "[ENABLE] HKCU_Camera"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Camera | Let apps access your camera --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -Value "Allow"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Camera | Let desktop apps access your camera --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam\NonPackaged" -Name "Value" -Value "Allow"
}
Function HKLM_Camera-Disable {
	Write-Output "[DISABLE] HKLM_Camera"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Camera | Camera access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -Value "Deny"
}
Function HKLM_Camera-Enable {
	Write-Output "[ENABLE] HKLM_Camera"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Camera | Camera access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -Value "Allow"
}

#### Microphone
Function HKCU_Microphone-Disable {
	Write-Output "[DISABLE] HKCU_Microphone"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Microphone | Let apps access your microphone --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" -Name "Value" -Value "Deny"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Microphone | Let desktop apps access your microphone --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone\NonPackaged" -Name "Value" -Value "Deny"	
}
Function HKCU_Microphone-Enable {
	Write-Output "[ENABLE] HKCU_Microphone"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Microphone | Let apps access your microphone --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" -Name "Value" -Value "Allow"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Microphone | Let desktop apps access your microphone --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone\NonPackaged" -Name "Value" -Value "Allow"
}
Function HKLM_Microphone-Disable {
	Write-Output "[DISABLE] HKLM_Microphone"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Microphone | Microphone access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" -Name "Value" -Value "Deny"
}
Function HKLM_Microphone-Enable {
	Write-Output "[ENABLE] HKLM_Microphone"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Microphone | Microphone access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" -Name "Value" -Value "Allow"
}

#### Voice activation
# *** By default all under "HKCU:\Software\Microsoft\Speech_OneCore\Settings" does not exist. It is created when this setting is accessed from UI for the first time.
Function HKCU_VoiceActivation-Disable {
	Write-Output "[DISABLE] HKCU_VoiceActivation"
	If (!(Test-Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps")) {
		New-Item -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -Force
	}
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Voice activation | Let apps access voice activation services --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -Name "AgentActivationEnabled" -Value 0
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Voice activation | Let apps use voice activation when device is locked --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -Name "AgentActivationOnLockScreenEnabled" -Value 0
}
Function HKCU_VoiceActivation-Enable {
	Write-Output "[ENABLE] HKCU_VoiceActivation"
	If (!(Test-Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps")) {
		New-Item -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -Force
	}
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Voice activation | Let apps access voice activation services --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -Name "AgentActivationEnabled" -Value 1
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Voice activation | Let apps use voice activation when device is locked --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -Name "AgentActivationOnLockScreenEnabled" -Value 1
}

#### Notifications
Function HKCU_Notifications-Disable {
	Write-Output "[DISABLE] HKCU_Notifications"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Notifications | Let apps access your notifications --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Name "Value" -Value "Deny"
}
Function HKCU_Notifications-Enable {
	Write-Output "[ENABLE] HKCU_Notifications"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Notifications | Let apps access your notifications --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Name "Value" -Value "Allow"
}
Function HKLM_Notifications-Disable {
	Write-Output "[DISABLE] HKLM_Notifications"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Notifications | Notification access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Name "Value" -Value "Deny"
}
Function HKLM_Notifications-Enable {
	Write-Output "[ENABLE] HKLM_Notifications"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Notifications | Notification access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Name "Value" -Value "Allow"
}

#### Account info
Function HKCU_AccountInfo-Disable {
	Write-Output "[DISABLE] HKCU_AccountInfo"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Account info | Let apps access your account info --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Value "Deny"
}
Function HKCU_AccountInfo-Enable {
	Write-Output "[ENABLE] HKCU_AccountInfo"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Account info | Let apps access your account info --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Value "Allow"
}
Function HKLM_AccountInfo-Disable {
	Write-Output "[DISABLE] HKLM_AccountInfo"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Account info | Account info access --> Disable"
	Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Value "Deny"
}
Function HKLM_AccountInfo-Enable {
	Write-Output "[ENABLE] HKLM_AccountInfo"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Account info | Account info access --> Enable"
	Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Value "Allow"
}

#### Contacts
Function HKCU_Contacts-Disable {
	Write-Output "[DISABLE] HKCU_Contacts"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Contacts | Let apps access your contacts --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" -Name "Value" -Value "Deny"
}
Function HKCU_Contacts-Enable {
	Write-Output "[ENABLE] HKCU_Contacts"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Contacts | Let apps access your contacts --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" -Name "Value" -Value "Allow"
}
Function HKLM_Contacts-Disable {
	Write-Output "[DISABLE] HKLM_Contacts"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Contacts | Contacts access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" -Name "Value" -Value "Deny"
}
Function HKLM_Contacts-Enable {
	Write-Output "[ENABLE] HKLM_Contacts"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Contacts | Contacts access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" -Name "Value" -Value "Allow"
}

#### Calendar
Function HKCU_Calendar-Disable {
	Write-Output "[DISABLE] HKCU_Calendar"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Calendar | Let apps access your calendar --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Name "Value" -Value "Deny"
}
Function HKCU_Calendar-Enable {
	Write-Output "[ENABLE] HKCU_Calendar"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Calendar | Let apps access your calendar --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Name "Value" -Value "Allow"
}
Function HKLM_Calendar-Disable {
	Write-Output "[DISABLE] HKLM_Calendar"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Calendar | Calendar access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Name "Value" -Value "Deny"
}
Function HKLM_Calendar-Enable {
	Write-Output "[ENABLE] HKLM_Calendar"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Calendar | Calendar access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Name "Value" -Value "Allow"
}

#### Phone calls
Function HKCU_PhoneCalls-Disable {
	Write-Output "[DISABLE] HKCU_PhoneCalls"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Phone calls | Let apps make phone calls --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" -Name "Value" -Value "Deny"
}
Function HKCU_PhoneCalls-Enable {
	Write-Output "[ENABLE] HKCU_PhoneCalls"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Phone calls | Let apps make phone calls --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" -Name "Value" -Value "Allow"
}
Function HKLM_PhoneCalls-Disable {
	Write-Output "[DISABLE] HKLM_PhoneCalls"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Phone calls | Phone call access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" -Name "Value" -Value "Deny"
}
Function HKLM_PhoneCalls-Enable {
	Write-Output "[ENABLE] HKLM_PhoneCalls"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Phone calls | Phone call access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" -Name "Value" -Value "Allow"
}

#### Call history
Function HKCU_CallHistory-Disable {
	Write-Output "[DISABLE] HKCU_CallHistory"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Call history | Let apps access your call history --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" -Name "Value" -Value "Deny"
}
Function HKCU_CallHistory-Enable {
	Write-Output "[ENABLE] HKCU_CallHistory"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Call history | Let apps access your call history --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" -Name "Value" -Value "Allow"
}
Function HKLM_CallHistory-Disable {
	Write-Output "[DISABLE] HKLM_CallHistory"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Call history | Call history access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" -Name "Value" -Value "Deny"
}
Function HKLM_CallHistory-Enable {
	Write-Output "[ENABLE] HKLM_CallHistory"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Call history | Call history access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" -Name "Value" -Value "Allow"
}

#### Email
Function HKCU_Email-Disable {
	Write-Output "[DISABLE] HKCU_Email"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Email | Let apps access your email --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" -Name "Value" -Value "Deny"
}
Function HKCU_Email-Enable {
	Write-Output "[ENABLE] HKCU_Email"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Email | Let apps access your email --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" -Name "Value" -Value "Allow"
}
Function HKLM_Email-Disable {
	Write-Output "[DISABLE] HKLM_Email"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Email | Email access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" -Name "Value" -Value "Deny"
}
Function HKLM_Email-Enable {
	Write-Output "[ENABLE] HKLM_Email"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Email | Email access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" -Name "Value" -Value "Allow"
}

#### Tasks
Function HKCU_Tasks-Disable {
	Write-Output "[DISABLE] HKCU_Tasks"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Tasks | Let apps access your tasks --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Name "Value" -Value "Deny"
}
Function HKCU_Tasks-Enable {
	Write-Output "[ENABLE] HKCU_Tasks"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Tasks | Let apps access your tasks --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Name "Value" -Value "Allow"
}
Function HKLM_Tasks-Disable {
	Write-Output "[DISABLE] HKLM_Tasks"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Tasks | Tasks access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Name "Value" -Value "Deny"
}
Function HKLM_Tasks-Enable {
	Write-Output "[ENABLE] HKLM_Tasks"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Tasks | Tasks access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Name "Value" -Value "Allow"
}

#### Messaging
Function HKCU_Messaging-Disable {
	Write-Output "[DISABLE] HKCU_Messaging"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Messaging | Let apps read messages --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" -Name "Value" -Value "Deny"
}
Function HKCU_Messaging-Enable {
	Write-Output "[ENABLE] HKCU_Messaging"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Messaging | Let apps read messages --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" -Name "Value" -Value "Allow"
}
Function HKLM_Messaging-Disable {
	Write-Output "[DISABLE] HKLM_Messaging"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Messaging | Messaging access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" -Name "Value" -Value "Deny"
}
Function HKLM_Messaging-Enable {
	Write-Output "[ENABLE] HKLM_Messaging"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Messaging | Messaging access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" -Name "Value" -Value "Allow"
}

#### Radios
Function HKCU_Radios-Disable {
	Write-Output "[DISABLE] HKCU_Radios"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Radios | Let apps control device radios --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" -Name "Value" -Value "Deny"
}
Function HKCU_Radios-Enable {
	Write-Output "[ENABLE] HKCU_Radios"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Radios | Let apps control device radios --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" -Name "Value" -Value "Allow"
}
Function HKLM_Radios-Disable {
	Write-Output "[DISABLE] HKLM_Radios"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Radios | Radio control access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" -Name "Value" -Value "Deny"
}
Function HKLM_Radios-Enable {
	Write-Output "[ENABLE] HKLM_Radios"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Radios | Radio control access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" -Name "Value" -Value "Allow"
}

#### Other devices
# **** HKLM "bluetoothSync" key exists but no control from Win11 UI - to be used in tweaks
Function HKCU_OtherDevices-Disable {
	Write-Output "[DISABLE] HKCU_OtherDevices"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Other devices | Communicate with unpaired devices --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" -Name "Value" -Value "Deny"
}
Function HKCU_OtherDevices-Enable {
	Write-Output "[ENABLE] HKCU_OtherDevices"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Other devices | Communicate with unpaired devices --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" -Name "Value" -Value "Allow"
}

#### App diagnostics
Function HKCU_AppDiagnostics-Disable {
	Write-Output "[DISABLE] HKCU_AppDiagnostics"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | App diagnostics | Let apps access diagnostic info about your other apps --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Value "Deny"
}
Function HKCU_AppDiagnostics-Enable {
	Write-Output "[ENABLE] HKCU_AppDiagnostics"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | App diagnostics | Let apps access diagnostic info about your other apps --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Value "Allow"
}
Function HKLM_AppDiagnostics-Disable {
	Write-Output "[DISABLE] HKLM_AppDiagnostics"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | App diagnostics | App diagnostic access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Value "Deny"
}
Function HKLM_AppDiagnostics-Enable {
	Write-Output "[ENABLE] HKLM_AppDiagnostics"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | App diagnostics | App diagnostic access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Value "Allow"
}

#### AutomaticFileDownloads
#### **** TO DO

#### Documents
Function HKCU_Documents-Disable {
	Write-Output "[DISABLE] HKCU_Documents"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Documents | Let apps access your documents library --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Value "Deny"
}
Function HKCU_Documents-Enable {
	Write-Output "[ENABLE] HKCU_Documents"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Documents | Let apps access your documents library --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Value "Allow"
}
Function HKLM_Documents-Disable {
	Write-Output "[DISABLE] HKLM_Documents"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Documents | Documents library access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Value "Deny"
}
Function HKLM_Documents-Enable {
	Write-Output "[ENABLE] HKLM_Documents"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Documents | Documents library access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Value "Allow"
}

#### Downloads folder
#### **** TO DO

#### Music library
#### **** TO DO

#### Pictures
Function HKCU_Pictures-Disable {
	Write-Output "[DISABLE] HKCU_Pictures"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Pictures | Let apps access your pictures library --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Value "Deny"
}
Function HKCU_Pictures-Enable {
	Write-Output "[ENABLE] HKCU_Pictures"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Pictures | Let apps access your pictures library --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Value "Allow"
}
Function HKLM_Pictures-Disable {
	Write-Output "[DISABLE] HKLM_Pictures"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Pictures | Pictures library access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Value "Deny"
}
Function HKLM_Pictures-Enable {
	Write-Output "[ENABLE] HKLM_Pictures"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Pictures | Pictures library access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Value "Allow"
}

#### Videos
Function HKCU_Videos-Disable {
	Write-Output "[DISABLE] HKCU_Videos"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Videos | Let apps access your videos library --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Value "Deny"
}
Function HKCU_Videos-Enable {
	Write-Output "[ENABLE] HKCU_Videos"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Videos | Let apps access your videos library --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Value "Allow"
}
Function HKLM_Videos-Disable {
	Write-Output "[DISABLE] HKLM_Videos"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Videos | Videos library access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Value "Deny"
}
Function HKLM_Videos-Enable {
	Write-Output "[ENABLE] HKLM_Videos"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | Videos | Videos library access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Value "Allow"
}

#### File system
Function HKCU_FileSystem-Disable {
	Write-Output "[DISABLE] HKCU_FileSystem"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | File system | Let apps access your file system --> Disable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Value "Deny"
}
Function HKCU_FileSystem-Enable {
	Write-Output "[ENABLE] HKCU_FileSystem"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | File system | Let apps access your file system --> Enable"
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Value "Allow"
}
Function HKLM_FileSystem-Disable {
	Write-Output "[DISABLE] HKLM_FileSystem"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | File system | File system access --> Disable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Value "Deny"
}
Function HKLM_FileSystem-Enable {
	Write-Output "[ENABLE] HKLM_FileSystem"
	Write-Output "[INFO] Settings | Privacy & security | App permissions | File system | File system access --> Enable"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Value "Allow"
}

#### Screenshot borders
#### **** TO DO

#### Screenshots and apps
#### **** TO DO










Export-ModuleMember -Function *