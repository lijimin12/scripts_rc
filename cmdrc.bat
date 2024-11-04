
:: USERPROFILE\bin\cmdrc.bat
:: "call cmdrc.bat" or "call cmdrc", no matter pwd
:: cannot be cmdrc.bat
:: my own cmd.exe rc, similar to .bashrc.own

@echo off

@set "PROMPT=$e[33m%PROMPT%$e[0m"

:: alias/doskey
:: path
doskey ..=cd ..
doskey ...=cd ..\..
doskey pwd=cd
doskey home=cd %HOMEPATH%

doskey ls=dir $*
REM order by date
doskey llrt="dir /OD"
doskey rm=del $*
doskey cat=type $*
doskey ps=tasklist
doskey which=where $*
REM cannot be used in "command | grep xxx"
REM doskey grep="findstr /i"
REM doskey source=call

doskey q=exit

:: GUI apps/tools
doskey ex=explorer $*
doskey np="C:\x\bin_tools\green\npp.7.8.bin.x64\notepad++.exe" $*
REM doskey npp="C:\x\bin_tools\green\npp.7.8.bin.x64\notepad++.exe" $*
doskey gvim="C:\Program Files (x86)\Vim\vim90\gvim.exe" $*

SET PATH=%PATH%;C:\x\bin_tools\green

@echo cmdrc in USERPROFILE\bin sourced, aliases defined, return
