@ECHO off
ECHO ########################################
ECHO # Package: Windows Tweaks Script
ECHO # Type: CMD (Command Line) / PowerShell
ECHO # Platform: Windows 11
ECHO # Source Code: https://github.com/michalselma/WinCTS
ECHO ########################################

REM Set current directory to the directory where file is run from
cd /d %~dp0

REM powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Tweaks.ps1"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Tweaks.ps1" -include "%~dp0/tweaks/*.psm1"

PAUSE