########################################
# Package: Windows Appx Packages Modification Script
# Type: CMD (Command Line) / PowerShell
# Platform: Windows 11
# Source Code: https://github.com/michalselma/WinCTS
########################################

# Build 3 separate add/remove/skip lists from appx config file
Function ProcessAppxConfig($cfgpath) {
	Write-Host "[INFO] Processing appx packages configuration file..."
	# Temporary variables to build remove/add/skip lists
	$cfgcontent = @()
	$add = @()
	$remove = @()
	$skip = @()

	# Read Config File
	$cfgcontent = Get-Content $cfgpath -ErrorAction Stop

	# Remove whitespaces at beggining and end of each object
	$cfgcontent = $cfgcontent | ForEach-Object {$_.Trim()}

	# Remove Empty lines/objects
	$cfgcontent = $cfgcontent | Where-Object {$_}

	# Remove comment lines from config file
	$cfgcontent = $cfgcontent | Where-Object { $_.Substring(0,1) -ne '#'}

    # Setting-up each option
	foreach ($app in $cfgcontent) {
		# Split each object on '=' and build key & value pairs
		$app = $app.split("=")
		# Remove wihtespaces at beggining and end of each app after split
		$app = $app.trim()
		# Build key-value 'pairs' (not necessary - just to keep clear code)
		$key=$app[0]
		$value=$app[1]
		if ($value -eq 0) {
			$remove += $key
		}
		elseif ($value -eq 1){
			$add += $key
		}
		elseif ($value -eq 2){
			$skip += $key
		}
		else {
			Write-Host "[ERROR] $key - Incorrect or empty switch in config file. Ignoring..."
		}
	}
	return $remove, $add, $skip
}

# Uninstall/Disable Microsoft applications for current user (must be admin)
Function UninstallAppx_currentuser($removeapps) {
	Write-Host "[INFO] Uninstalling Microsoft AppxPackages for current user..."
	if ($removeapps.length -eq 0){
		Write-Host "[INFO] Uninstallation/Removal list is empty. Skipping..."
    }
	else {
		foreach ($app in $removeapps) {
			# Get system info if app is installed for current user
			$isAppInstalled = Get-AppxPackage -Name $app | Select-Object -ExpandProperty Name -First 1 # -First 1 takes first row when more than 1 is returned
			# Remove whitespaces
			$isAppInstalled = $isAppInstalled | ForEach-Object { $_.Trim() }
			if ($isAppInstalled -ne $app){
				Write-Host "[WARN] $app not installed for current user or package not found. Skipping..."
			}
			else {
				Write-Host "[INFO] Uninstalling $app for current user. Reinstalltion still will be possible."
				$PackageFullName = Get-AppxPackage -Name $app | Select-Object -ExpandProperty PackageFullName -First 1 # -First 1 takes first row when more than 1 is returned
				# Remove for current (admin) user
				Remove-AppxPackage -Package $PackageFullName #-erroraction silentlycontinue
			}
		}
	}
}

# Uninstall/Disable Microsoft applications for all users other than current user (must be admin)
Function UninstallAppx_allusers($removeapps) {
	Write-Host "[INFO] Uninstalling Microsoft AppxPackages for all users other than current user..."
	if ($removeapps.length -eq 0){
		Write-Host "[INFO] Uninstallation/Removal list is empty. Skipping."
    }
	else {
		foreach ($app in $removeapps) {
			# Get system info if app is installed for any of users
			$isAppInstalled = Get-AppxPackage -Name $app -AllUsers | Select-Object -ExpandProperty Name -First 1 # -First 1 takes first row when more than 1 is returned
			# Remove whitespaces
			$isAppInstalled = $isAppInstalled | ForEach-Object { $_.Trim() }
			if ($isAppInstalled -ne $app){
				Write-Host "[WARN] $app not installed for any of users or package not found. Skipping..."
			}
			else {
				Write-Host "[INFO] Uninstalling $app for all users other than current user. Reinstalltion for existsing users or installation for new users still will be possible."
				$PackageFullName = Get-AppxPackage -Name $app -AllUsers | Select-Object -ExpandProperty PackageFullName -First 1 # -First 1 takes first row when more than 1 is returned
				# Remove for all users except current (admin) user.
				# Will throw error at the end, as after 
				# which is non-removable by this command: ""
				Remove-AppxPackage -Package $PackageFullName -AllUsers #-erroraction silentlycontinue
				#### ***KE2209001*** Package uninstall for all users throws error at the end. 
				#### After removal from last local user package will move automatically to staged status/user ({S-1-5-18 [S-1-5-18]: Staged}), 
				#### which is not removabe by "Remove-AppxPackage" command. Regardless error package is being removed for all local users."
				#### Problem is when such staged package is not provisioned (eg. Microsoft.Windows.Photos in Win11) - TODO: search for removal options.
			}
		}
	}
}

# Remove Microsoft applications permanently from the system
Function RemoveAppx_SysProvisioned($removeapps) {
	Write-Host "[INFO] Removing Microsoft AppxPackages permanently from the system..."
	if ($removeapps.length -eq 0){
		Write-Host "[INFO] Uninstallation/Removal list is empty. Skipping..."
    }
	else {
		foreach ($app in $removeapps) {
			# Get system info if app does exist as provisioned package
			# TO CHECK: Seems when it runs as 3rd stage after current and all users removal in Windows 11 
			# Throws Waring that app not found as provisioned package - Maybe stage 2 removes it permanently ?
			$isAppProvisioned = Get-AppxProvisionedPackage -Online | WHERE DisplayName -eq $app | Select-Object -ExpandProperty DisplayName -First 1 # -First 1 takes first row when more than 1 is returned
			# Remove whitespaces
			$isAppProvisioned = $isAppProvisioned | ForEach-Object { $_.Trim() }
			if ($isAppProvisioned -ne $app){
				Write-Host "[WARN] System provisioned package $app not found. Skipping..."		
			}
			else {
				Write-Host "[INFO] Removing $app permanently from the system (System Provisioned Uninstall/Removal)."
				# This is permanent removal incl. physical appx files/folders delete from "C:\Program Files\WindowsApps\"
				# Physical files removal will take place only when app removed for all users.
				# Even this option is run first and then app is removed for local users, after removal of last user should delete files as well.
				# This is the only way to remove app when it is at staged status : "{S-1-5-18 [S-1-5-18]: Staged}"
				$ProvisionedPackageName = Get-AppxProvisionedPackage -Online | WHERE DisplayName -eq $app | Select-Object -ExpandProperty PackageName -First 1 # -First 1 takes first row when more than 1 is returned
				# Permanent removal for new (future) users. Note: not all 'Get-AppxPackage' exists in 'Get-AppxProvisionedPackage' (Not every package is provisioned)
				Remove-AppxProvisionedPackage -Online -PackageName $ProvisionedPackageName -AllUsers #-erroraction silentlycontinue
			}
		}
	}
}

# Install/Add Microsoft applications for current user
Function InstallAppx_currentuser($addapps) {
	Write-Host "[INFO] Installing Microsoft AppxPackages..."
	if ($addapps.length -eq 0){
		Write-Host "[INFO] Installation list is empty. Skipping..."
	}
	else {
		foreach ($app in $addapps) {
			# Check if app exists for installtion
			$isAppAvailable = Get-AppxPackage -Name $app -AllUsers | Select-Object -ExpandProperty Name -First 1
			# Get system info if app is installed for current user
			$isAppInstalled = Get-AppxPackage -Name $app | Select-Object -ExpandProperty Name -First 1
			# Remove whitespaces
			$isAppAvailable = $isAppAvailable | ForEach-Object { $_.Trim() }
			$isAppInstalled = $isAppInstalled | ForEach-Object { $_.Trim() }
			if ($isAppAvailable -ne $app) {
				Write-Host "[ERROR] $app does not exist in the system. Not able to install/activate it for current user."
			}
			elseif ($isAppInstalled -eq $app) {
				Write-Host "[WARN] $app already installed for current user. Skipping..."
			}
			else {
				Write-Host "[INFO] Installing $app for current user"
				Get-AppxPackage -Name $app -AllUsers | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
			}
		}
	}
}

# Modules/Functions Export
Export-ModuleMember -Function *
