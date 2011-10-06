##|  colinta
export HISTCONTROL=ignoreboth
export LSCOLORS="gx""fx""cx""dx""Bx""eg""ed""ab""ag""ac""ad"
export TERM="xterm-256color"

if [ -z $SHDIR ]; then
  if [ -d ~/.sh ]; then
    export SHDIR=~/.sh
  elif [ -d ~/sh ]; then
    export SHDIR=~/sh
  fi
fi

test -r "$SHDIR"/git-completion.bash && source "$SHDIR"/git-completion.bash
test -r "$SHDIR"/bash_completion && source "$SHDIR"/bash_completion
test -r "$SHDIR"/gitprofile && source "$SHDIR"/gitprofile

export PS1='\033[31m\h\033[0m \w \[\033[33m\]$(git_prompt_info)\[\033[0m\] \[\033[31m\]$(git_status)\[\033[0m\]\n\$ '

test -x /usr/sbin/apache2ctl && alias configtest="sudo /usr/sbin/apache2ctl configtest"
test -x /etc/init.d/apache2 && alias apache='sudo /etc/init.d/apache2'

alias ls='ls -G'
alias l1='ls -1'
alias la='ls -la'

##|
##|  shell options, if they are available
##|    extglob - see below
##|    globstar - **/* recursive searching
##|    autocd - directory names act like commands
##|    no_empty_cmd_completion - tab on empty line does nothing
for opt in extglob globstar autocd no_empty_cmd_completion
do
  [[ -n `shopt | grep $opt` ]] && shopt -s $opt
done
