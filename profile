source /usr/local/bin/virtualenvwrapper.sh
alias vim="mvim -v"
alias fbmvc="./fbmvc"
alias wimp="curl -L automation.whatismyip.com/n09230945.asp"
alias dba="mysql --user=root --password=fb3141"
EDITOR="mvim -v"; export EDITOR
SHDIR=~/.sh
source $SHDIR/profile
# Add paths for standard brew install directories
PATH=/usr/local/bin:/usr/local/share/python:$PATH
export PATH
PYTHONPATH=/usr/local/share/python:$PYTHONPATH; 
export PYTHONPATH
PROMPT_COMMAND=$PROMPT_COMMAND; history -a; 
export PROMPT_COMMAND
shopt -s histappend
WORKON_HOME=$HOME/.virtualenvs
export WORKON_HOME
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin
export VIRTUALENVWRAPPER_PYTHON
