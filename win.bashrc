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
    find . -iname '*'${1}'*' -not -path '*/.*' -print
    # find . -iname '*'${1}'*' -not -path '*/.*' -print | tee /dev/stderr | head -1 | clip      # seems sth wrong, such as `in /c/my/tech, f "*.md"`
}
alias f='f.n'

# find a markdown notes file, and put results into windows clipboard
mf ()
{
    if [ "$1" = '-h' ] || [ $# -ne 1 ] ; then 
        echo "Usage: $FUNCNAME FILENAME_PATTERN"; 
        return; 
    fi
    # ${1%.md} is to remove file extention name
    # find /c/my /c/codes/Jimin-Z8 /c/x -iname '*'${1%.md}'*.md' -not -path '*/.*' -print | tee /dev/stderr | head -1 | clip
    find /c/my /c/codes/Jimin-Z8 /c/x -iname '*'${1%.md}'*.md' -not -path '*/.*' -print
}
alias fm=mf

# find .md and .txt files modified in last 1 day
alias mf1='find /c/my /c/codes/Jimin-Z8 /c/x /c/users/jiminli/Desktop /c/users/jiminli/Downloads -type f \( -iname "*.md" -o -iname "*.txt" \) -mtime -1 -exec stat --printf="%y %n\n" {} \; | sort'
# last 3 days
alias mf3='find /c/my /c/codes/Jimin-Z8 /c/x /c/users/jiminli/Desktop /c/users/jiminli/Downloads -type f \( -iname "*.md" -o -iname "*.txt" \) -mtime -3 -exec stat --printf="%y %n\n" {} \; | sort'
# last 1 week (7 days)
alias mf7='find /c/my /c/codes/Jimin-Z8 /c/x /c/users/jiminli/Desktop /c/users/jiminli/Downloads -type f \( -iname "*.md" -o -iname "*.txt" \) -mtime -7 -exec stat --printf="%y %n\n" {} \; | sort'
# current workday (12 hours)
alias mftoday='find /c/my /c/codes/Jimin-Z8 /c/x /c/users/jiminli/Desktop /c/users/jiminli/Downloads -type f \( -iname "*.md" -o -iname "*.txt" \) -mmin -720 -exec stat --printf="%y %n\n" {} \; | sort'


# grep in .md markdown notes, or grep on my own notes
# alias mg='g -nr --include="*.md" --exclude-dir="_NYTimes" --exclude-dir=w '
# grep in certain folders rather than pwd
# use $* instead of $1, so as we can use `mg -w tc`
# to grep "--color=auto", `mg -- --color=auto`
function mg ()
{
	if [ $# -eq 0 ] || [ "$1" = '-h' ]; then 
        echo "Usage: $FUNCNAME ARGS"; 
        echo -e "e.g.\t$FUNCNAME PATTERN";
        echo -e "e.g.\t$FUNCNAME -w PATTERN";
        echo "DONT include blank space in PATTERN, user \s instead, such as mg 'foo\s\+bar', mg 'ip\scommand', double-quote ok as well"
        echo "Can use 'mg intel.xpu' where . means any char"
        return; 
    fi
    # set -x
    g -nr --include="*.md" --include="*.txt" \
    --exclude-dir="_NYTimes" --exclude-dir=bin_tools --exclude-dir=w_mchp --exclude-dir=GPU --exclude-dir=Intel_tools --exclude-dir=RDC --exclude-dir=_downloaded --exclude-dir=Linux_Kernel --exclude-dir=Programming_Language \
    $* /c/x /c/my/tech /c/codes/Jimin-Z8
    # set +x
    #grep -I --color=auto -nr -i --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" ${1} /c/my /c/codes/Jimin-Z8 /c/x
}
# grep on my own notes (.md and .txt)
alias gm=mg

# only grep .md, while not .txt
# just copy the function mg
function mdg ()
{
	if [ $# -eq 0 ] || [ "$1" = '-h' ]; then 
        echo "Usage: $FUNCNAME ARGS"; 
        echo -e "e.g.\t$FUNCNAME PATTERN";
        echo -e "e.g.\t$FUNCNAME -w PATTERN";
        echo "DONT include blank space in PATTERN, user \s instead, such as mg 'foo\s\+bar', mg 'ip\scommand', double-quote ok as well"
        echo "Can use 'mg intel.xpu' where . means any char"
        return; 
    fi
    # set -x
    g -nr --include="*.md" \
    --exclude-dir="_NYTimes" --exclude-dir=bin_tools --exclude-dir=w_mchp --exclude-dir=GPU --exclude-dir=Intel_tools --exclude-dir=RDC --exclude-dir=_downloaded --exclude-dir=Linux_Kernel --exclude-dir=Programming_Language \
    $* /c/x /c/my/tech /c/codes/Jimin-Z8
    # set +x
    #grep -I --color=auto -nr -i --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" ${1} /c/my /c/codes/Jimin-Z8 /c/x
}
alias gmd=mdg

# grep .md in current folder
# e.g. in /c/codes/Jimin-Z8, mdg -A8 "^pitch"
alias mdg.='g -nr --include="*.md" --include="*.txt" '

# example, `mgsection gitbash`
function mgsection ()
{
    # copied, possible edit needed
	if [ $# -eq 0 ] || [ "$1" = '-h' ]; then 
        echo "Usage: $FUNCNAME ARGS"; 
        echo -e "e.g.\t$FUNCNAME PATTERN";
        echo -e "e.g.\t$FUNCNAME -w PATTERN";
        echo "DONT include blank space in PATTERN, user \s instead, such as mg 'foo\s\+bar', mg 'ip\scommand', double-quote ok as well"
        return; 
    fi

    #mg '^#' | grep -i $*
    mg '^#\+\s' | grep -i $*
}
alias mgheader='mgsection'

function mgtags ()
{
    # copied, possible edit needed
	if [ $# -eq 0 ] || [ "$1" = '-h' ]; then 
        echo "Usage: $FUNCNAME ARGS"; 
        echo -e "e.g.\t$FUNCNAME PATTERN";
        echo -e "e.g.\t$FUNCNAME -w PATTERN";
        echo "DONT include blank space in PATTERN, user \s instead, such as mg 'foo\s\+bar', mg 'ip\scommand', double-quote ok as well"
        return; 
    fi

    mg '^tags' | grep -i $*
}

# find RDC
frdc ()
{
	if [ $# -ne 1 ]; then echo "Usage: $FUNCNAME FILENAME_PATTERN"; return; fi
    # ${1%.md} is to remove file extention name
    #x=$(find /c/x /c/Users/jiminli/Downloads -iname '*'${1}'*' -not -path '*/.*' -print | tee /dev/stderr | head -1 | clip)    # clip impacts whole command result value
    #x=$(find /c/x /c/Users/jiminli/Downloads -iname '*'${1}'*' -not -path '*/.*' -print | tee /dev/stderr | head -1)
    x=$(find /c/x /c/Users/jiminli/Downloads -iname '*'${1}'*' -not -path '*/.*' -print)
    #echo "$x"
    if [ "$x" = "" ] ; then
        echo "not found"
    else
        echo "$x"
        echo "$x" | clip
    fi
}
alias rdcf=frdc
alias rdc='frdc'

# find and open rdc pdf
# only one argument: $1 RDC#
# do open only when there is excatly a single found file 
fordc ()
{
	if [ $# -ne 1 ]; then echo "Usage: $FUNCNAME RDC#"; return; fi
    # set -o pipefail
	# find -name "*${1}*.pdf" -print0 | xargs -0 AcroRd32.exe

    r=$(find /c/x /c/Users/jiminli/Downloads -iname "*${1}*.pdf")
    # echo "'$r'"
    count=$(echo -n "$r" | wc -l)
    # echo $count
    if [ -n "$r" ] && [ $count == 0 ] ; then
        AcroRd32.exe "$r" &
        # echo do_open
    else
        # print found rdc files
        echo "$r"
    fi
}

# open pdf from in gitbash
# only one argument: PDF_FILE_PATH
pdf ()
{
	if [ $# -ne 1 ]; then echo "Usage: $FUNCNAME PDF_FILE_PATH"; return; fi
    # set -o pipefail
	# find -name "*${1}*.pdf" -print0 | xargs -0 AcroRd32.exe

    # AcroRd32.exe "${1}" &
    FoxitPDFReader.exe "${1}" &
}


# find on windows in my own folders and Downloads etc.
# e.g. `wf wallpaper`
wf ()
{
    if [ "$1" = '-h' ] || [ $# -ne 1 ] ; then 
        echo "Usage: $FUNCNAME FILENAME_PATTERN"; 
        return; 
    fi
    # find /c/my /c/codes/Jimin-Z8 /c/x $HOME/Downloads/ $HOME/Screenshots/ $HOME/Videos/ -iname '*'${1}'*' -not -path '*/.*' -print | tee /dev/stderr | head -1 | clip
    find /c/my /c/codes/Jimin-Z8 /c/x $HOME/Downloads/ $HOME/Screenshots/ $HOME/Videos/ -iname '*'${1}'*' -not -path '*/.*' -print
}


# cd certain folder on Windows Laptop
alias hub='cd /c/codes/Jimin-Z8/'
alias z8='hub'
alias z8notes='cd /c/codes/Jimin-Z8/notes'
alias z8scripts='cd /c/codes/Jimin-Z8/scripts'
alias x='cd /c/x/'
alias xnotes='cd /c/x/my_x_notes'
# linux codes tree
alias lk='cd /c/codes/linux-6.6/linux-6.6_unzipped'
alias lk515='cd /c/codes/linux-5.15-unzipped/linux-5.15'
alias lk5='lk515'


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

alias ipa='ipconfig | grep -B 5 -i ipv4'

# as a notice to user
echo 'alias/function(s):' 'ex', 'wf FILENAME', 'mf FILENAME', 'mftoday', 'mg STRING', 'mgsection SECTION_NAME', 'cg/mdg', 'rdcf RDC#', 'rdco RDC#', 'vv|vs|np' 

#cd /c/x
# use instead "C:\Program Files\Git\git-bash.exe" --cd="C:\x"

# .md shown in cyan color
export LS_COLORS="$LS_COLORS:*.md=36"

echo "Jimin-Z8\win.bashrc sourced"

# things put in windows ~/.bashrc
# vim90 needs to be after $PATH
#export PATH=/c/x/bin_tools/green/npp.7.8.bin.x64/:$PATH:"/c/Program Files (x86)/Vim/vim90/":"/c/Program Files (x86)/Foxit Software/Foxit PDF Reader":'C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\'
#alias fox='FoxitPDFReader.exe" '
#alias pdf='"AcroRd32.exe"'

# after 'git push' to github, get beige do 'git pull'
#alias beigepull='ssh lijimin1@beige.sh.intel.com "cd /home/lijimin1/my_repo/scripts; git pull"'
#alias moro='ssh nex@nex-morocity.sh.intel.com'
#alias archer='ssh pae@pae-archercity.sh.intel.com'
#alias editvsmd='code "C:\Users\jiminli\AppData\Local\Programs\Microsoft VS Code\resources\app\extensions\markdown-basics\language-configuration.json"'
