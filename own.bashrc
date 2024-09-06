# This is my own bashrc shared by my Linux and Windows, and public server
# ~/own.bashrc
# make ~/own.bashrc a symbol link to my downloaded Jimin-hub repo.

# if [ -f ~/own.bashrc ]; then
#   . ~/own.bashrc [extra]
# fi
# two modes available: standard (the default) and extra. Can be specified via parameter
# seems unwise to maintain minimal and standard versions

# own.bashrc.standard
# avoid duplication in own.bashrc and own.bashrc.extra

#####################################
# beginmark for public server. 
# Just copy to public server the part from begin to end marks!
# remove comments before paste?
# if [ -f ~/.bashrc.pub.server ]; souce ~/.bashrc.pub.server ; fi
# if this own.bashrc used as a whole one, then _PLATFORM_FLAG != ""
# inside this if clause are server specific 
# 为什么在此处增加 PS1，这样文件中有重复两处设置了?
# 上面有一堆条件判断是设置它，我希望 .bashrc.pub.server中不需要这些判断逻辑，而采用简单明了的方式
# 该文件的使用方式：
# 1. 在一般情况下（BEIGE, WINDOWS），整个文件不加修改地使用
# 2. 在LINUX PUB SERVER上，提取服务器标记之间的内容
# need proxy as well in lab?

if [ "$OS" != "Windows_NT" ]; then
# no need to set proxy on windows laptop
#export http_proxy="http://child-prc.intel.com:913"
#export https_proxy="http://child-prc.intel.com:913"
#export ftp_proxy="ftp://child-prc.intel.com:913"
# NOTE: proxy setting moved to /etc/environment
:
#export no_proxy='localhost, 127.0.0.1, intel.com, .intel.com'
#export http_proxy="http://proxy-prc.intel.com:912"
#export https_proxy="http://proxy-prc.intel.com:912"
fi

if [ "$OS" != "Windows_NT" ]; then
echo ""
# echo "NOT Windows_NT"

# title and prompt
TITLEBAR=""
if [ "$TERM" = xterm ]; then
# putty and gitbash both go here
# note: if TITLEBAR is empty, then putty will show "IP - PuTTY" as the window title by default
# note: \u - user, \h - hostname, \w - pwd, $(hostname -I) IP address
# hostname -I | grep -o "\<10\.[0-9]*\.[0-9]*\.[0-9]*"
TITLEBAR='\[\033]0;\u@\h $(hostname -I | grep -o "\<10\.[0-9]*\.[0-9]*\.[0-9]*") \w\007\]'
#TITLEBAR='\[\033]0;\u@\h $(hostname -I) \w\007\]'
fi
# ubuntu Terminal GUI xterm-256color
case "$TERM" in
    xterm-*)
    TITLEBAR='\[\033]0;\u@\h \w\007\]'
    ;;
esac
if [ "$TERM" = screen ]; then
# screen goes here
TITLEBAR='\[\033]0;[screen] \u@\h $(hostname -I) \w\007\]'
fi
# add \n to insert a new line
export PS1="${TITLEBAR}\n[\u \[\033[0;33m\]\h \[\033[1;34m\]\w\[\033[0m\]]\$ "
export PROMPT_DIRTRIM=2

#export PATH=~/bin:~/.local/bin:$PATH
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
else
echo "Windows_NT"
# In windows, i.e. gitbash, 
# 1. we don't need to set PS1, as it's done by /etc/bash.bashrc
# 2. we don'ts need to set proxy
fi

# history
# HISTCONTROL=ignoreboth
unset HISTCONTROL
export HISTIGNORE="ls:ll:pwd"
shopt -s histappend     # append to history, don't overwrite it
export HISTSIZE=1000    # default is 1000
export HISTFILESIZE=2000
# export HISTTIMEFORMAT="%F %T "
# %F means YYYY-MM-DD
# %y/%m/%d
# `who am i` can show the ip address of ssh client
#export HISTTIMEFORMAT="%m/%d %T `who am i` | "
export HISTTIMEFORMAT="%m/%d %T "
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
#export PROMPT_COMMAND="history -a && history -c && history -r; $PROMPT_COMMAND"
export PROMPT_COMMAND="history -a && history -c && history -r" # not include the origin one to avoid duplication in case of screen
# export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND" not work
# NOTE: `history -c` would look like not working, as PROMPT_COMMAND refills the history buffer from HISTFILE

# single char aliases
# get a b c x y z reserved
# dir
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'   # - to 'cd -'
# alias b='cd -'  # go back
alias p='pwd'
alias pd='pushd'
alias pop='popd'
alias dirs='dirs -p'

#alias h='history'
#alias h='history -a; history -c; history -r; history | tail -20'
# we hope type h in console a can show commands just excuted in console b of the same user
# history -n doesn't work as expected.
#alias h='history -c ; history -r; history 20'
alias h='history 20'
#alias hh='history -a; history -c; history -r; history' # full history
#alias hh='history -c; history -r; history' # full history
alias hh='history 100'
alias hhh='history' # full history
alias nohist='unset PROMPT_COMMAND; export HISTSIZE=0'
alias offhist='nohist'  # turn off history
alias v='vim'
alias t='type'
alias what='type'
# w not alias

alias al='alias'
# list alias and functions
#alias alf="(declare -F | awk '{print \$NF}' | sort | egrep -v '^_' ; alias | awk '{print \$2}') | sort"
alias alf="(declare -F | awk '{print \$NF}' | sort | egrep -v '^_' ; alias | awk '{\$1="'""'"; \$0 = \$0; \$1 = \$1; print \$0}') | sort"

# alias vi="vim"
# other single char aliases (f, g etc.) are defined below

alias clr="clear && printf '\033[3J'"

# word count dos '\r'
alias wcdos="grep -cU $'\r'"
alias chkdos=wcdos
# word count tab '\t'
alias wctab="grep -cU $'\t'"
alias chktab=wctab

alias path="printenv PATH | tr ':' '\n'"
# alias path="printenv PATH | tr : '\n'"
# alias paths='printenv PATH | sed -e '\''s/[Cc]:/\\C/g'\'' | sed -e '\''s/:/\n/g'\'
# to support "C:\Programs" in gitbash
alias paths="printenv PATH | sed -e 's/[Cc]:/\\\\C/g' | sed -e 's/:/\n/g'"
alias ldpath="printenv LD_LIBRARY_PATH | tr ':' '\n'"

# human readable
alias cp='cp -v'    # verbose
alias free='free -h'
alias df='df -Th'
alias iostat='iostat -d -h' # only blk devices, and in human friendly output format
# time-stamp
alias dmesg='sudo dmesg -T'
alias dmsg='dmesg'
alias dmsgerr='dmesg --level=err'
alias derr=dmsgerr
alias where='whereis'
alias du1='du -h --max-depth=1 | sort -rh'
alias cpuid='cpuid -1'  # first logical cpu core
alias ln='ln -s'    # soft link
alias term='echo $TERM' # sometimes, like to check if it's screen
# all of ttyX, gnome-terminal, sshd 
alias shells='pstree -pT | grep -A 1 -nw -e sshd -e gnome-terminal -e login -e screen'
alias shs='shells'

# turn off bash bell beep
bind 'set bell-style none'

# ctrl-d to delete word
# by default, ctrl-w to delete word backwardly
bind '"\C-d": kill-word'	# forward, i.e. right to cursor
bind '"\eOC": forward-word'
bind '"\eOD": backward-word'


# some more ls aliases
alias ls='ls --color=auto'  # as the default color mode is 'none'
alias l='ls -F'     # e.g. append "/" to denote folder
alias ll='ls -AlFh' # -A vs. -a
alias la='ls -A'
#alias lf="ls -l | grep -vE '^d|^l' | awk '{print $9}'"
# for links, $10 would be "->"
alias ld='ls -d */'     # list only directories
alias lf='ls -p | grep -v ./ | xargs ls --color=auto'   # list only regular files
# alias ld="ls -l | grep -E '^d|^l' | awk '{print \$9,\$10}' | column"     # list only directories
# alias lf="ls -l | grep -E '^-|^l' | awk '{print \$9,\$10}' | column"     # list only regular files
# reversely time sorted
alias llrt='ll -rt'
# sort by file size
alias llsize='ll -rSh'
alias llsz='llsize'
# list only .* hidden files and or directories
alias l.='ls -d .*'
alias l.d='ls -d .*/'
alias l.f='ls -pd .* | grep -v ./ | xargs ls --color=auto'
# alias l.d="ls -dl .* | grep -E '^d|^l' | awk '{print \$9,\$10}'"
##alias l.f="ls -dl .* | grep -E '^-|^l' | awk '{print \$9,\$10}'"
# exclude Desktop Documents etc.
alias lsown="ls -F | sed -e '/Desktop/d' -e '/Documents/d' -e '/Downloads/d' -e '/Music/d' -e '/Pictures/d' -e '/Public/d' -e '/Templates/d' -e '/Videos/d' -e '/snap/d'"

# grep aliases
#alias grep='grep -I --exclude-dir=".svn" --exclude-dir=".git" --exclude-dir=".repo" --color=auto'
alias grep='grep -I --exclude-dir=".*" --color=auto'
# alias grep='grep -I --color=auto'
alias g='grep -nr -i -s'
# -s, --no-messages
# Suppress error messages about nonexistent or unreadable files.
alias fgrep='fgrep -I --exclude-dir=".svn" --exclude-dir=".git" --exclude-dir=".repo" --color=auto'

# on server, sometimes we also need grep .c and .py files
# grep recursively in c source files
#alias cg='g -nr --include="*.c" --include="*.h"'
alias cg='g -nr --include="*.c" --include="*.cpp" --include="*.S" --include="*.h"'
# python grep
alias pg='g -nr --include="*.py" '

# endmark for public server
#####################################

# search text files (.txt .md)
#alias tg='g -nr --include="*.txt" --include="*.md" --exclude-dir="_NYTimes" --exclude-dir=w '
# linux kernel source grep = cg + excluding some folders
# all archs except x86 excluded
# excluded dirs are sorted by size, with drivers take more than half the whole linux kernel source codes
# linux v6.6
# 1.5G    .
# 976M    ./drivers
# 143M    ./arch
# 68M     ./tools
# 68M     ./Documentation
# 53M     ./include
# 50M     ./sound
# 47M     ./fs
# 36M     ./net
# 14M     ./kernel
# 8.1M    ./lib
# 5.4M    ./mm
# 3.9M    ./crypto
# 3.8M    ./scripts
# 3.4M    ./security
alias lg='g -nr --include="*.c" --include="*.S" --include="*.h" --exclude-dir={"tools","Documentation","sound","fs","crypto","scripts","security"} --exclude-dir={alpha,arc,arm,arm64,csky,h8300,hexagon,ia64,loongarch,m68k,microblaze,mips,nds32,nios2,openrisc,parisc,powerpc,riscv,s390,sh,sparc,um,xtensa} '
# exclude drivers
alias lgndrv='g -nr --include="*.c" --include="*.S" --include="*.h" --exclude-dir={"drivers","tools","Documentation","sound","fs","crypto","scripts","security"} --exclude-dir={alpha,arc,arm,arm64,csky,h8300,hexagon,ia64,loongarch,m68k,microblaze,mips,nds32,nios2,openrisc,parisc,powerpc,riscv,s390,sh,sparc,um,xtensa} '
# linux kernel grep
# use $* instead of $1 to support 'lgg -w pattern'
# seems work in Linux, but not in gitbash
lgg() {

    if [ $# -eq 0 ] || [ "$1" = '-h' ] ; then
        echo "Usage: $FUNCNAME PATTERN; $FUNCNAME -w PATTERN"
        return
    fi
    # run it at the root of linux kernel source codes tree
    if [[ $(basename `pwd`) =~ .*(inux|INUX|ernel|ERNEL).* ]]; then
        echo "in kernel source code root, go ahead"
    else
        echo "not in root kernel source code, exit"
        return
    fi
    grep -nr --include={"*.c","*.S","*.h"} --exclude-dir={"sound","fs","drivers","Documentation","arch","crypto"} $* . ./arch/x86
}

# linux grep struct definition, e.g. lgstruct platform_driver
lgstruct() {
    if [ $# -eq 0 ] || [ "$1" = '-h' ] ; then
        echo "Usage: $FUNCNAME PATTERN"
        return
    fi
    grep -nr --include={"*.c","*.S","*.h"} -w "struct\s${1}\s\+{"
}

# exlude 'build'
alias gnb='grep --exclude-dir="build"'
# grep: warning: GREP_OPTIONS is deprecated; please use an alias or script
# export GREP_OPTIONS="--exclude-dir=\.git --exclude-dir=\.svn"


# excluding middle path name matching
locate() {
    if [ $# -eq 0 ] || [ "$1" = '-h' ] ; then
        echo "Usage: $FUNCNAME PATTERN"
		echo "  e.g. locate intel-i915-dkms"
        return
    fi
    /usr/bin/locate ${1} | /usr/bin/grep --color=auto ${1}'[^/]*$'
}
alias locatef='locate'  # locate file, excluding folder
alias locateb='locate -b'   # basename

# git
alias gitnp='git --no-pager'
# list git aliases
alias gital='git config -l  | grep ^alias'

alias vimrc='vim ~/.bashrc'
alias vv='vimm.py'


if [ "$OS" != "Windows_NT" ]; then
# preserve environment
# alias sudo="sudo -E "
# alias sudo='sudo -E'
# no need to carry environemnt to sudo. If there are some env setting needed by sudo, put it in /etc/environment
:
fi


export EDITOR='vim'


# hardly remember those defined find functions. it serves as examples and can check them online with type command.
# find . -name
f.n ()
{
    if [ $# -eq 0 ] || [ "$1" = '-h' ] ; then
        echo "find . -name"
        echo "Usage: $FUNCNAME PARTIAL_NAME"
        return
    fi
    find . -name '*'${1}'*' -not -path '*/.*' -print
}
alias f='f.n'

# find . -name fully
f.nf ()
{
    if [ $# -eq 0 ] || [ "$1" = '-h' ] ; then
        echo "find . -name"
        echo "Usage: $FUNCNAME FULL_NAME"
        return
    fi
    find . -name ${1} -not -path '*/.*' -print
}

# find files in .
# f.f
# f.f -iname NAME
f.f() {
    if [ $# -eq 0 ] || [ "$1" = '-h' ] ; then
        echo "find regular files in ."
        echo "Usage: $FUNCNAME [ARGS]"
        echo '$FUNCNAME -iname "hello.c"'
        return
    fi
    find . -not -path '*/.*' -not -type d $* -print
}

# find excluding build folder
f.xb() {
    if [ $# -eq 0 ] || [ "$1" = '-h' ] ; then
        echo "find in ., excluding 'build' folder"
        echo "Usage: $FUNCNAME ARGS"
        echo '$FUNCNAME -iname "hello.c"'
        return
    fi
    find . -path '*/build' -prune -o $* -print
}

# alias mkcd='function mkcdf(){ mkdir "$1"; cd "$1"; }; mkcdf'
mkcd() { 
    if [ $# -eq 0 ] || [ "$1" = '-h' ] ; then
        echo "Usage: $FUNCNAME DIRETORY_NAME"
        return
    fi

    mkdir -p "$1" && cd "$1" 
}

# alias rmp='pwd=`pwd` && ! test -L "$pwd" && cd .. && rm -rfv "$pwd" || { test -L "$pwd" && cd .. && unlink "${pwd}" && echo unlinked "$pwd". ; }  || echo failed'
alias rmp='pwd=`pwd` && ! test -L "$pwd" || { test -L "$pwd" && echo "failed, $pwd is a symbol link" ; false; } && cd .. && rm -rfv "$pwd" '

alias rm.='rmp'

echo_color () {
    if [ $# -ne 2 ] ; then
        echo "wrong number of function parameters"
        echo "Usage: $FUNCNAME COLOR MESSAGE"
        echo "COLOR: red, green, yellow ..."
        return
    fi

    color=$1
    message=$2
    case $color in
        red)
            echo -e "\033[1;31m"${message}"\033[0m"
            ;;
        green)
            echo -e "\033[1;32m"${message}"\033[0m"
            ;;
        yellow)
            echo -e "\033[1;33m"${message}"\033[0m"
            ;;
        *) echo "unsupported COLORNAME $color"
    esac
}

echo_yellow () {
    if [ $# -ne 1 ] ; then
        echo "Usage: $FUNCNAME MESSAGE"
        return
    fi
    echo_color yellow "$1"
}

# remove current dir forcely
rmpwd() {
    if [ $# -ne 0 ] ; then
        echo "Usage: $FUNCNAME"
        echo "remove pwd"
        return
    fi

    pwd=$(pwd)
    if [ -d $pwd ] && [ ! -L $pwd ]; then

        if [ -z "$(ls -A $pwd)" ]; then
            echo -e "remove" "\033[1;33m"empty"\033[0m" $pwd
            cd .. && rmdir -v $pwd
        else
            echo -e "remove" "\033[1;33m"non-empty"\033[0m" $pwd
            cd .. && rm -rfv $pwd && echo_yellow "$pwd removed"
        fi
    fi

    if [ -d $pwd ] && [ -L $pwd ]; then
        # cd ..
        # echo "unlink $pwd"
        # unlink $pwd
        echo "failed, $pwd is a symbol link"
    fi
}

# two command formats supported:
# ca FILENAME [LINENUMBER [CONTEXT=3]]
# ca FILENAME:[LINENUMBER:[CONTEXT=3]]
ca () {
	if [ $# -eq 0 ] || [ "$1" = '-h' ] ; then
        echo 'Usage: '
        echo "  $FUNCNAME FILENAME [LINENUMBER [CONTEXT=3]]";
        echo "  $FUNCNAME FILENAME:[LINENUMBER:[CONTEXT=3]]";
        return;
    fi
	# if [ $# -eq 1 ]; then cat "$1"; return; fi
    if [ $# -eq 1 ]; then
        # $1 might be "/path/to/file[:1[:2]]"
        source <(echo "$1" | awk 'BEGIN { FS="[: \t|]" } {print "x="$1";", "y="$2";", "z="$3";"}')
        if [ "$y" = "" ]; then
            # no :linenumber[:context] provided
            cat "$1";
            return;
        else
            filepath=${x}
            line=${y}
            c=${z:-3}
        fi
    else
        # $# = 2 or 3
        filepath=${1}
        line=${2}
	    c=${3:-3}	# default context is 3
    fi
	cat -n "$filepath" | head -$(($line + $c)) | tail -$(($c * 2 + 1))
}

# check trailing comments in a file
check_trailing_comments () {
	if [ $# -eq 0 ] || [ "$1" = '-h' ] ; then
        echo "Usage: $FUNCNAME FILENAME";
        return;
    fi

	# grep '#' "$*" | grep -v '^\s*#'  | grep '\s#'
	grep -nv '^\s*#' "$*" | grep '\s#'
    # grep -n '[^[:space:]]\s\+#'
	# [:space:] cannot be replaced with \s
	# can work on both Linux and windows gitbash
	# sed -n  -e  '/[^[:space:]]\s\+#\s.*$/ p' own.bashrc
}


# print history related settings
printhist () {
    echo "HISTFILE: $HISTFILE"
    echo "HISTSIZE: $HISTSIZE"
    echo "HISTFILESIZE: $HISTFILESIZE"
    echo "HISTTIMEFORMAT: $HISTTIMEFORMAT"
    echo "HISTCONTROL: $HISTCONTROL"
    echo "HISTIGNORE: $HISTIGNORE"
    shopt histappend
    shopt histreedit
    shopt histverify
}


# check if there's own files
# check_own_files ~
# TODO: improve it
check_own_files () {
	if [ $# -eq 0 ] || [ "$1" = '-h' ] ; then
        echo "Usage: $FUNCNAME HOMEDIR";
        return;
    fi

    pushd $1

    # ls -A
    # new unhidden files and folder
    ls -1F | grep -v -e Desktop  -e Documents -e Downloads -e Music -e Pictures -e Public -e Templates -e Videos -e snap

    # hidden files and folders
    ls -dF1 .*

    for dir in Desktop Documents Downloads Music Pictures Public snap Templates Videos ; do
        ls -l $dir
    done

    popd
}

status_repos () {
    # for repodir in */ ; do (cd ${repodir}; echo ""; basename `pwd`; git status -sb; cd ..) ; done
    # for repodir in */ ; do (cd ${repodir}; echo ""; x=$(basename `pwd`); echo "$x"; if [ "$x" == "${x#_}" ]; then git status -sb; fi) ; done
    for repodir in */ ; do (cd ${repodir}; echo ""; x=$(basename `pwd`); echo "$x"; if [ "${x::1}" != "_" ]; then git status -sb; else echo "this folder skipped"; fi) ; done
}

sync_repos () {
    # for repo in Computer  Linux  notes pix_markdown onenote geo ; do (cd $repo; basename `pwd` ; git pull) ; done
    for repodir in */ ; do (cd $repodir; echo ""; basename `pwd` ; git pull) ; done
}
alias repos_status='status_repos'
alias repos_sync='sync_repos'

# as a notice to user
echo 'alias/function(s):' 'f', 'g', 'mkcd', 'rmp', 'ca FILENAME LINENUMBER CONTEXT' 

########################################

# if using the minimal mode, skip the rest
# NOTE $1 have to be put in ""
if [ "$1" = "full" ] ; then
    :
    #echo "full own.bashrc required"
elif true ; then
	# echo "my github standard own.bashrc sourced"
    echo "standard Jimin-hub\own.bashrc sourced"
	return
fi


if [ "$OS" != "Windows_NT" ]; then

# go to certain folders
# alias lk='cd ~/wsp_nvme0/linux_torvalds'

# NOTE: ctl-a + ctl-x to quit picocom
alias ttyUSB='picocom -b 115200 /dev/ttyUSB1'

# export LC_ALL=en_US.UTF-8

# to take most likely needed options
# human readable
alias lsscsi='lsscsi -s'    # -s means size
alias lsusb='lsusb -vt'     # verbose, tree
alias lsblk='lsblk --fs'    # file system
alias ss='ss -4ap'  # ipv4, all, process
alias pgrep='pgrep -ia' # grep process via name
alias lsb_release='lsb_release -a'

# insert individual projects alias etc.
# 
fi


echo "full Jimin-hub\own.bashrc sourced"
