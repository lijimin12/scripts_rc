@echo off
REM cmd.exe /c c:\x\bin_tools\proxy_status.bat
reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable 
pause
