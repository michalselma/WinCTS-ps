@ECHO off
ECHO ########################################
ECHO # Package: Windows Power Options Script
ECHO # Type: CMD (Command Line) / PowerShell
ECHO # Platform: Windows 11
ECHO # Source Code: https://github.com/michalselma/WinCTS
ECHO ########################################

REM Set current directory to the directory where file is run from
cd /d %~dp0

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0PowerOptions.ps1" -Verb RunAs

PAUSE