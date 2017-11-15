# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
set editing-mode vi
set -o vi
# Avoid duplicates
export HISTSIZE=100000
export HISTCONTROL=ignoredups:erasedups  
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
export PROMPT_COMMAND=__prompt_command  # Func to gen PS1 after CMDs

function __prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    local RCol='\[\e[0m\]'

    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'

    if [ $EXIT != 0 ]; then
        PS1+="${Red}\u${RCol}"      # Add red if exit code non 0
    else
        PS1+="${Gre}\u${RCol}"
    fi
    PS1+="${RCol}@${BBlu}\h ${Pur}\W${BYel}$ ${RCol}"
    #PS1 +="\[\033[38;5;34m\]\h\[$(tput sgr0)\]\[\033[38;5;1m\]\\$\[$(tput sgr0)\]"
    history -a; history -c; history -r
}

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# some more ls aliases
alias xc="xclip -selection c"
export EDITOR="vim"
export VISUAL="$EDITOR"


export PATH="$PATH:/usr/local/bin/"
export VIM=~/.vim
alias rsy="rsync -av -P"
#if [ -z ${LD_LIBRARY_PATH+x} ]; then export LD_LIBRARY_PATH=/usr/lib:usr/lib64:~/bin/lib:/home/hsafield/.vim/bundle/YouCompleteMe/third_party/ycmd; fi
#if [ -z ${C_INCLUDE_PATH+x} ]; then export C_INCLUDE_PATH=~/bin/include:~/src/Python-3.5.0b2; fi
#if [ -z ${CPLUS_INCLUDE_PATH+x} ]; then export CPLUS_INCLUDE_PATH=~/bin/include:~/src/Python-3.5.0b2; fi
export TERM=screen-256color
###-begin-leetcode-completions-###
#
# yargs command completion script
#
# Installation: leetcode completion >> ~/.bashrc
#    or leetcode completion >> ~/.bash_profile on OSX.
#
_yargs_completions()
{
    local cur_word args type_list

    cur_word="${COMP_WORDS[COMP_CWORD]}"
    args=("${COMP_WORDS[@]}")

    # ask yargs to generate completions.
    type_list=$(leetcode --get-yargs-completions "${args[@]}")

    COMPREPLY=( $(compgen -W "${type_list}" -- ${cur_word}) )

    # if no match was found, fall back to filename completion
    if [ ${#COMPREPLY[@]} -eq 0 ]; then
      COMPREPLY=( $(compgen -f -- "${cur_word}" ) )
    fi

    return 0
}
complete -F _yargs_completions leetcode
###-end-leetcode-completions-###

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

move_sinks_to(){
	echo "Setting default sink to: $1";
	pacmd set-default-sink $1
	pacmd list-sink-inputs | grep index | while read line
do
	echo "Moving input: ";
	echo $line | cut -f2 -d' ';
	echo "to sink: $1";
	pacmd move-sink-input `echo $line | cut -f2 -d' '` $1
done
}
