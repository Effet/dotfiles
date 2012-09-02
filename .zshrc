#!/usr/bin/env zsh


# {{{ Environmental Variables

export PATH=~/Scripts/:~/Scripts/acm/:$PATH
export EDITOR='emacsclient -c -a emacs'
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# History
export HISTSIZE=1000
export SAVEHIST=1000

# }}}
# {{{ Functions/Alias

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ee="emacsclient -c -a emacs"

# http://emacs-fu.blogspot.com/2011/12/system-administration-with-emacs.html
alias E="SUDO_EDITOR=\"emacsclient -c -a emacs\" sudoedit"


mk-cd() {
  mkdir "$@" && cd "$@"
}

alias zb="cat /dev/urandom | hexdump -C | grep --color=auto \"ca fe\""

# }}}
# {{{ Completions

autoload -U compinit && compinit
setopt completealiases
setopt complete_in_word

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'


[ -f /etc/DIR_COLORS ] && eval $(dircolors -b /etc/DIR_COLORS)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# http://forums.gentoo.org/viewtopic-t-204402-start-0.html
# killall <tab>
zstyle ':completion:*:processes-names' command 'ps -e -o comm='
# kill <tab>
zstyle ':completion:*:processes' command 'ps -au$USER' 
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'


# http://jarod.wikidot.com/zsh-configuration
# Group matches and Describe
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'


# http://grml.org/zsh/zsh-lovers.html
# Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# }}}

# {{{ Keybindings

bindkey -e                      # Emacs-style
bindkey "\e[3~" delete-char     # Backward delete chars


# http://grml.org/zsh/zsh-lovers.html
# Another method for quick change directories. Add this to your ~/.zshrc, then just enter “cd …./dir”
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot


# https://github.com/ran9er/desert/blob/master/zshrc#L239
user-ret(){
    if [[ $BUFFER = "" ]] ;then
        BUFFER="ls -lh"
        zle end-of-line
        zle accept-line
    elif [[ $BUFFER =~ "^cd\ \.\.\.+$" ]] ;then
          BUFFER=${${BUFFER//\./\.\.\/}/\.\.\//}
        zle end-of-line            
        zle accept-line
    else
        zle accept-line
    fi
}
zle -N user-ret
bindkey "\r" user-ret

# }}}


# Bash-style `/` seprate `word`.
autoload -U select-word-style
select-word-style bash

autoload -U colors && colors
autoload -U promptinit && promptinit
prompt gentoo
