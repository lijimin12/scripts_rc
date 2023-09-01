#
# in ~/.bashrc for gitbash on windows
# 	source "C:\codes\Jimin-Z8\scripts\win.bashrc"
# 	echo "Jimin-Z8\win.bashrc sourced"

alias ..='cd ..'
alias ...='cd ../..'
alias clr="clear && printf '\033[3J'"


# dir
alias b='cd -'
alias p='pwd'
alias ..='cd ..'
alias ...='cd ../..'

alias clr="clear && printf '\033[3J'"
alias al='alias'
alias h='history'
alias v="vim"
# alias vi="vim"
alias vv='vimm.py'

# some more ls aliases
alias ls='ls --color=auto'  # as the default color mode is 'none'
alias l='ls -F'     # e.g. append "/" to denote folder
alias ll='ls -AlFh'
alias la='ls -A'
# reversely time sorted
alias llrt='ll -rt'
# sort by file size
alias llsize='ll -rSh'
alias llsz='llsize'

alias grep='grep -I --color=auto'
alias g='grep -nr -i'
alias cg='g -nr --include="*.c" --include="*.cpp" --include="*.S" --include="*.h"'
# python grep
alias pg='g -nr --include="*.py" '
# search text files (.txt .md)
#alias tg='g -nr --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" --exclude-dir=w '

# word count dos '\r'
alias wcdos="grep -cU $'\r'"
# word count tab '\t'
alias wctab="grep -cU $'\t'"


#alias tg='g -nr --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" /c/my /c/codes/Jimin-Z8 /c/x '
# g -nr --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" ${1} /c/my /c/codes/Jimin-Z8 /c/x

# find . -name
f.n ()
{
    find . -iname '*'${1}'*' -not -path '*/.*' -print
}
alias f='f.n'

# find a markdown notes file
mf ()
{
    find /c/my /c/codes/Jimin-Z8 /c/x -iname '*'${1}'*.md' -not -path '*/.*' -print
}

# grep in .md markdown notes
alias mg='g -nr --include="*.md" --exclude-dir="_NYTimes" --exclude-dir=w '
# grep in certain folders rather than current one
function mg ()
{
    g -nr --include="*.md" --exclude-dir="_NYTimes" --exclude-dir=bin_tools --exclude-dir=w ${1} /c/x /c/my/tech /c/codes/Jimin-Z8
    #grep -I --color=auto -nr -i --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" ${1} /c/my /c/codes/Jimin-Z8 /c/x
}

# copied from own.bashrc
# dont modify here
mkcd() { 
    mkdir -p "$1" && cd "$1" 
}

alias rmp='pwd=`pwd` && ! test -L "$pwd" || { test -L "$pwd" && echo "failed, $pwd is a symbol link" ; false; } && cd .. && rm -rfv "$pwd" '
# remove current dir forcely
rmpwd() {
    pwd=$(pwd)
    if [ -d $pwd ] && [ ! -L $pwd ]; then

        if [ -z "$(ls -A $pwd)" ]; then
            echo -e "remove" "\033[1;33m"empty"\033[0m" $pwd
            cd .. && rmdir -v $pwd
        else
            echo -e "remove" "\033[1;33m"non-empty"\033[0m" $pwd
            cd .. && rm -rfv $pwd
        fi
    fi

    if [ -d $pwd ] && [ -L $pwd ]; then
        # cd ..
        # echo "unlink $pwd"
        # unlink $pwd
        echo "failed, $pwd is a symbol link"
    fi
}

# as a notice to user
echo 'alias/function(s):' 'mkcd', 'rmp', 'mf FILENAME', 'mg STRING' 


alias path="printenv PATH | tr : '\n'"
alias codes='cd /c/codes'
# gitbash special, invalid on Linux
#alias npp='/c/x/bin_tools/green/npp.7.8.bin.x64/notepad++.exe'
#alias np='notepad'
alias np='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" "npp"'
alias gvim='"C:\Program Files (x86)\Vim\vim90\gvim.exe"'
alias vv='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" vim'
# vs code
alias vs='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" code'
alias ex='explorer'

#cd /c/x
# use instead "C:\Program Files\Git\git-bash.exe" --cd="C:\x"

