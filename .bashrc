# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

. /etc/apache2/envvars

# If not running interactively, don't do anything else
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export LS_ARGS=--color=auto
export GREP_ARGS=--color=auto

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls $LS_ARGS'
    alias ll='ls $LS_ARGS -l'
    alias la='ls $LS_ARGS la'
    alias dir='dir $LS_ARGS'
    alias vdir='vdir $LS_ARGS'

    alias grep='grep $GREP_ARGS'
    alias fgrep='fgrep $GREP_ARGS'
    alias egrep='egrep $GREP_ARGS'
fi

export rvm_silence_path_mismatch_check_flag=1

alias apt-get='sudo apt-get'
alias :q="echo 'This is not vim ye daft idiot!' && sleep 2 && exit"
alias mckd="mkdir
alias nethack="ssh nethack@nethack.alt.org"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
export PATH=$PATH:/usr/games:.
export PS1='\[\e[1;32m\]aaronryank\[\e[m\]@\[\e[1;34m\]\w\[\e[m\]\[\e[33m\]\[$(__git_ps1 " (%s)")\] \[\e[1;35m\]->\[\e[m\] '

# make commands case-insensitive, thanks @DennisMitchell
if [[ "$(type -t command_not_found_handle)" == function ]]; then
        eval "$(printf 'lowercase_%s' "$(declare -f command_not_found_handle)")"
else
        lowercase_command_not_found_handle ()
        {
                printf "$0: $1: command not found\n" >&2
                return 127
        }
fi

command_not_found_handle ()
{
        if [[ "${1,,}" != "$1" ]]; then
                "${1,,}" "${@:2}"
        else
                lowercase_command_not_found_handle "$@"
        fi
}

# make dir, cd to it.
mkcd()
{
    mkdir $1
    cd $1
}
