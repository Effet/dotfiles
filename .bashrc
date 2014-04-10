txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

PS1="\[${txtblk}\]\w\[${txtrst}\] \[${txtblu}\]>\[${txtrst}\] "
PS2="\[${txtblk}\]. \[${txtrst}\]"


## Environment
#@see http://wiki.gentoo.org/wiki/Wine#Disabling_the_Menubuilder
# Prevent Wine from adding menu entries and desktop links.
export WINEDLLOVERRIDES='winemenubuilder.exe=d'

export PATH=$HOME/.rvm/bin:$PATH

export JAVA_HOME=$HOME/opt/jdk1.6.0_45/
export M2_HOME=/opt/maven/

## Alias
alias ls='ls -b -CF --color=auto'
alias ll='ls -l'
alias l='ll'
alias lh='ls -Alh'
alias cls='clear;ls'
alias cll='clear;ll'

alias grep='grep --color=auto'
alias igrep='grep -i'

alias r='fc -s'

alias vi='vim'

alias em='emacsclient -nc -a ""'
alias emc='emacsclient -t -a ""'
#alias kem='emacsclient -e "(save-buffers-kill-emacs)"'
alias kem='emacsclient -e "(kill-emacs)"'

alias rscp='rsync -av --progress --stats'

# http://emacs-fu.blogspot.com/2011/12/system-administration-with-emacs.html
alias E="SUDO_EDITOR=\"emacsclient -c -a emacs\" sudoedit"


## Functions
mkcd() { mkdir -p "$*" && cd "$*";}

# Remove current directory if empty
rmcdir() { cd ..; rmdir $OLDPWD || cd $OLDPWD;}

check_cmd_exist() {
    type "$1" >/dev/null 2>&1
}

# Delete orphans in archlinux -> https://github.com/tonkazoid/dots/blob/master/.bashrc#L37-L43
orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No orphans to remove."
    else
        sudo pacman -Rs $(pacman -Qdtq)
    fi
}
