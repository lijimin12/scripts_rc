#
# in ~/.bashrc for gitbash on windows
#   source "C:\codes\Jimin-Z8\scripts\own.bashrc"
# 	source "C:\codes\Jimin-Z8\scripts\win.bashrc"
# 	echo "Jimin-Z8\win.bashrc sourced"
#
# only win.bashrc speicial aliases put here. common on Linux and Windows put in own.bashrc


if [ "$OS" != "Windows_NT" ]; then
    echo "warning: this win.bashrc should be sourced only on Windows"
    return
fi

#alias tg='g -nr --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" /c/my /c/codes/Jimin-Z8 /c/x '
# g -nr --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" ${1} /c/my /c/codes/Jimin-Z8 /c/x

# find . -name
# and put results into windows clipboard
f.n ()
{
	if [ $# -ne 1 ]; then echo 'Usage: f.n FILENAME_PATTERN'; return; fi
    # find . -iname '*'${1}'*' -not -path '*/.*' -print
    find . -iname '*'${1}'*' -not -path '*/.*' -print | tee /dev/stderr | head -1 | clip
}
alias f='f.n'

# find a markdown notes file, and put results into windows clipboard
mf ()
{
	if [ $# -ne 1 ]; then echo 'Usage: mf FILENAME_PATTERN'; return; fi
    # ${1%.md} is to remove file extention name
    find /c/my /c/codes/Jimin-Z8 /c/x -iname '*'${1%.md}'*.md' -not -path '*/.*' -print | tee /dev/stderr | head -1 | clip
}
alias fm=mf

# grep in .md markdown notes
# alias mg='g -nr --include="*.md" --exclude-dir="_NYTimes" --exclude-dir=w '
# grep in certain folders rather than pwd
# use $* instead of $1, so as we can use `mg -w tc`
# to grep "--color=auto", `mg -- --color=auto`
function mg ()
{
	if [ $# -eq 0 ] || [ "$1" = '?' ]; then 
        echo "Usage: $FUNCNAME ARGS"; 
        echo -e "e.g.\t$FUNCNAME PATTERN";
        echo -e "e.g.\t$FUNCNAME -w PATTERN";
        return; 
    fi
    # set -x
    g -nr --include="*.md" --exclude-dir="_NYTimes" --exclude-dir=bin_tools --exclude-dir=w $* /c/x /c/my/tech /c/codes/Jimin-Z8
    # set +x
    #grep -I --color=auto -nr -i --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" ${1} /c/my /c/codes/Jimin-Z8 /c/x
}
alias gm=mg

# find RDC
frdc ()
{
	if [ $# -ne 1 ]; then echo "Usage: $FUNCNAME FILENAME_PATTERN"; return; fi
    # ${1%.md} is to remove file extention name
    find /c/x /c/Users/jiminli/Downloads -iname '*'${1}'*' -not -path '*/.*' -print | tee /dev/stderr | head -1 | clip
}
alias rdcf=frdc

# open pdf
# only one argument: $1 RDC#
# do open only when there is excatly a single found file 
opdf ()
{
	if [ $# -ne 1 ]; then echo 'Usage: opdf RDC#'; return; fi
    # set -o pipefail
	# find -name "*${1}*.pdf" -print0 | xargs -0 AcroRd32.exe

    r=$(find /c/x /c/Users/jiminli/Downloads -iname "*${1}*.pdf")
    # echo "'$r'"
    count=$(echo -n "$r" | wc -l)
    # echo $count
    if [ -n "$r" ] && [ $count == 0 ] ; then
        AcroRd32.exe "$r"
        # echo do_open
    else
        # print found rdc files
        echo "$r"
    fi
}
alias ordc=opdf
alias rdco=ordc

# cd certain folder
alias hub='cd /c/codes/Jimin-Z8/Scripts'

# gitbash special, invalid on Linux
#alias npp='/c/x/bin_tools/green/npp.7.8.bin.x64/notepad++.exe'
#alias np='notepad'
alias np='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" "npp"'
#alias gvim='"C:\Program Files (x86)\Vim\vim90\gvim.exe"'
alias vv='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" vim'
# gvim
alias gv='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" gvim'
# vs code
alias vs='"C:\Users\jiminli\AppData\Local\Programs\Python\Python38\python.exe" "C:\codes\Jimin-Z8\scripts\editor_wrapper.py" code'

# alias ex='explorer'
# ex '\c\x'
# ex '\x'
# ex 'c:\x'
# ex /c/x
# ex /x
# ex c:/x
# all above can work
ex () {
	if [ $# -ne 1 ]; then echo "Usage: $FUNCNAME /PAHT/TO/DIR_or_FILE"; return; fi
    # echo /c/x/Core/11th-Tiger-Lake | sed -e 's/\//\\/g' | sed -e 's/^\\c/c:/'
    filepath=$(echo $1 | sed -e 's/\//\\/g' | sed -e 's/^\\c/c:/')
    # echo $filepath
    explorer $filepath
}

# as a notice to user
echo 'alias/function(s):' 'ex', 'mf FILENAME', 'mg STRING', 'rdcf RDC#', 'rdco RDC#', 'vv|vs|np' 

#cd /c/x
# use instead "C:\Program Files\Git\git-bash.exe" --cd="C:\x"

echo "Jimin-Z8\win.bashrc sourced"