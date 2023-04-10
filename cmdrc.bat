
:: USERPROFILE\bin\cmdrc.bat
:: "call cmdrc.bat" or "call cmdrc", no matter pwd
:: cannot be cmdrc.bat
:: my own cmd.exe rc, similar to .bashrc.own

@echo off

@set "PROMPT=$e[33m%PROMPT%$e[0m"

:: alias/doskey
doskey ..=cd ..
doskey ...=cd ..\..
doskey ls=dir
doskey pwd=cd
doskey home=cd %HOMEPATH%
doskey rm=del
doskey cat=type
doskey ps=tasklist
doskey which=where
REM order by date
doskey llrt="dir /OD"

doskey ex=explorer $*
REM doskey source=call
doskey np="C:\x\bin_tools\green\npp.7.8.bin.x64\notepad++.exe" $*
doskey gvim="C:\Program Files (x86)\Vim\vim90\gvim.exe" $*

@echo cmdrc sourced, aliases defined, return
