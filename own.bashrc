# ~/bashrc.own
# make ~/bashrc.own a symbol link to my downloaded repo.

# if [ -f ~/bashrc.own ]; then
#   . ~/bashrc.own [full]
# fi
# two modes available: minimal (the default) and standard/full. Can be specified via parameter


# bashrc.own.minimal
# avoid duplication in bashrc.own and bashrc.own.minimal

export http_proxy="http://child-prc.intel.com:913"
export https_proxy="http://child-prc.intel.com:913"
export ftp_proxy="ftp://child-prc.intel.com:913/"
#export http_proxy=http://child-prc.intel.com:913
#export https_proxy=http://child-prc.intel.com:913
#export no_proxy='localhost, 127.0.0.1, intel.com, .intel.com'


# title and prompt
TITLEBAR=""
if [ "$TERM" = xterm ]; then
# putty goes here
# note: if TITLEBAR is empty, then putty will show "IP - PuTTY" as the window title by default
# note: \u - user, \h - hostname, \w - pwd, $(hostname -I) IP address
TITLEBAR='\[\033]0;\u@\h $(hostname -I) \w\007\]'
fi
# ubuntu Terminal GUI xterm-256color
case "$TERM" in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h \w\007\]'
    ;;
esac
if [ "$TERM" = screen ]; then
# screen goes here
TITLEBAR='\[\033]0;[screen] \u@\h $(hostname -I) \w\007\]'
fi
export PS1="${TITLEBAR}[\u \[\033[0;33m\]\h \[\033[1;34m\]\w\[\033[0m\]]\$ "
export PROMPT_DIRTRIM=2


# export HISTTIMEFORMAT="%F %T "
# %F means YYYY-MM-DD
# %y/%m/%d
export HISTTIMEFORMAT="%m/%d %T "

#export PATH=~/bin:~/.local/bin:$PATH
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH


# go back
alias b='cd -'
alias p='pwd'
alias ..='cd ..'
alias ...='cd ../..'

alias clr="clear && printf '\033[3J'"
alias h='history'
alias v='vim'
alias t='type'

# preserve environment
# alias sudo="sudo -E "
alias sudo='sudo -E'


# turn off bash bell
bind 'set bell-style none'

# ctrl-d to delete word
# by default, ctrl-w to delete word backwardly
bind '"\C-d": kill-word'	# forward, i.e. right to cursor

##########

# if using the minimal mode, skip the rest
if [ $1 = full ] ; then
    :
    #echo "full bashrc.own required"
elif true ; then
	echo "my github minimal bashrc.own sourced, return"
	return
fi


export EDITOR='vim'
export GREP_OPTIONS="--exclude-dir=\.git --exclude-dir=\.svn"

alias path="printenv PATH | tr ':' '\n'"
alias al='alias'
alias v="vim"
# alias vi="vim"
alias vv='vimm.py'

alias grep='grep -I --exclude-dir=".svn" --exclude-dir=".git" --exclude-dir=".repo" --color=auto'
alias g='grep'
# exlude 'build'
alias gnb='grep --exclude-dir="build"'
# grep recursively in c source files
#alias cg='g -nr --include="*.c" --include="*.h"'
alias cg='g -nr --include="*.c" --include="*.cpp" --include="*.S" --include="*.h"'
# linux kernel source grep = cg + excluding some folders
# all archs except x86 excluded
alias lg='g -nr --include="*.c" --include="*.S" --include="*.h" --exclude-dir={"sound","fs","drivers","Documentation","crypto"} --exclude-dir={alpha,arc,arm,arm64,csky,hexagon,ia64,loongarch,m68k,microblaze,mips,nios2,openrisc,parisc,powerpc,riscv,s390,sh,sparc,um,xtensa} '

# word count dos '\r'
alias wcdos="grep -cU $'\r'"
# word count tab '\t'
alias wctab="grep -cU $'\t'"

alias gitnp='git --no-pager'
# lias git aliases
alias gital='git config -l  | grep ^alias'
alias virc='vim ~/.bashrc'
alias ll='ls -ahlF'
# list only .* files and directories
alias l.='ls -d .*'
# list only .* files
alias l.f="ls -dl .* | grep -v '^d' | awk '{print \$9}'"
#alias lk='cd ~/wsp/linux_kernel'
alias lk='cd ~/wsp_nvme0/linux_torvalds'


# NOTE: ctl-a + ctl-x to quit picocom
alias ttyUSB='picocom -b 115200 /dev/ttyUSB1'

# human readable
alias free='free -h'
alias df='df -Th'
alias lsblk='lsblk --fs'
# time-stamp
alias dmesg='dmesg -T'
alias ss='ss -4ap'  # ipv4, all, process

# insert individual projects alias etc.
# 

# find . -name
f.n ()
{
    find . -name '*'${1}'*' -not -path '*/.*' -print
}
alias f='f.n'

# find . -name fully
f.nf ()
{
    find . -name ${1} -not -path '*/.*' -print
}

# find file
ff() {
    find ${1} -not -path '*/.*' -not -type d -print
}

# find excluding build folder
f.xb() {
    find . -path '*/build' -prune -o $* -print
}

# alias mkcd='function mkcdf(){ mkdir "$1"; cd "$1"; }; mkcdf'
mkcd() { 
    mkdir -p "$1" && cd "$1" 
}

# alias rmp='pwd=`pwd` && ! test -L "$pwd" && cd .. && rm -rfv "$pwd" || { test -L "$pwd" && cd .. && unlink "${pwd}" && echo unlinked "$pwd". ; }  || echo failed'
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


echo "my github standard/full bashrc.own sourced"

