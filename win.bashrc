#
# in ~/.bashrc for gitbash on windows
# 	source "C:\codes\Jimin-Z8\scripts\win.bashrc"
# 	echo "Jimin-Z8\win.bashrc sourced"

alias ..='cd ..'
alias ...='cd ../..'
alias clr="clear && printf '\033[3J'"
alias lsize='ls -lrSh'

alias grep='grep -I --color=auto'
alias g='grep -nr -i'
alias cg='g -nr --include="*.c" --include="*.cpp" --include="*.S" --include="*.h"'
# python grep
alias pg='g -nr --include="*.py" '
# search text files (.txt .md)
#alias tg='g -nr --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" --exclude-dir=w '


#alias tg='g -nr --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" /c/my /c/codes/Jimin-Z8 /c/x '
# g -nr --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" ${1} /c/my /c/codes/Jimin-Z8 /c/x

# find . -name
f.n ()
{
    find . -iname '*'${1}'*' -not -path '*/.*' -print
}
alias f='f.n'

# find a text notes file
tf ()
{
    find /c/my /c/codes/Jimin-Z8 /c/x -iname '*'${1}'*' -not -path '*/.*' -print
}

# grep in .md markdown notes
alias mg='g -nr --include="*.md" --exclude-dir="_NYTimes" --exclude-dir=w '
# grep in certain folders rather than current one
mgg ()
{
    g -nr --include="*.md" --exclude-dir="_NYTimes" --exclude-dir=bin_tools --exclude-dir=w ${1} /c/x /c/my/tech /c/codes/Jimin-Z8
    #grep -I --color=auto -nr -i --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" ${1} /c/my /c/codes/Jimin-Z8 /c/x
}

alias path="printenv PATH | tr : '\n'"
alias codes='cd /c/codes'
# gitbash special, invalid on Linux
alias npp='/c/x/bin_tools/green/npp.7.8.bin.x64/notepad++.exe'
#alias np='notepad'
alias np='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" npp'
alias gvim='"C:\Program Files (x86)\Vim\vim90\gvim.exe"'
alias vv='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" vim'
# vs code
alias vs='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" code'
alias ex='explorer'
cd /c/x

