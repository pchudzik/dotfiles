. ~/.dotfiles/git-completion.bash

alias ll='ls -lFh'
alias la='ls -A'
alias l='ls -CF'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias sublime=/home/pawel/Tools/Sublime/sublime_text

alias m=mvn
complete -F _mvn m

alias g=git
__git_complete g __git_main

alias pu="pushd"
alias po="popd"

psgrep() {
	ps -aux | grep $1 | grep -v grep	
}

alias o=open
