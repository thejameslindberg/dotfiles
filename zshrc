#!/usr/bin/env zsh
#-------------------------------------------------------
#   zshrc - Overview
#-------------------------------------------------------
#   This file is the gateway to configuring the entire
#   dotfiles system for zsh.  In terms of base aliases,
#   functions, environment exports, etc., this is the
#   only file that needs to be symlinked to one's home
#   directory.  Beyond that, the remainder is contained
#   wherever the Git repository was cloned.

#--------------------------------------------------
#   Determines operating system, root directory
#   of dotfiles, and autoloads several basic zsh
#   options
#--------------------------------------------------
os=${OSTYPE//[0-9.]/}
dotfile_dir=$(dirname $(readlink "${HOME}/.zshrc"))
typeset -U path manpath fpath
autoload colors zsh/terminfo
autoload -U compinit
autoload run-help
compinit

#--------------------------------------------------
#   Sets shorthand variables for some common colors
#   that we're going to use
#--------------------------------------------------
[[ "$terminfo[colors]" -ge 8 ]] && colors
PR_NO_COLOR="%{$terminfo[sgr0]%}"
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
  (( count = $count + 1 ))
done

#--------------------------------------------------
#   Go through dotfiles.d one file at a time and
#   source files at the first level
#--------------------------------------------------
for snippet in ${dotfile_dir}/dotfiles.d/*[^~]; do
  source $snippet
done

#--------------------------------------------------
#   Determine the git branch and status if we're in
#   a git repository.  Also sets up both the left 
#   and right prompt
#--------------------------------------------------
git_br='$(get_git_prompt_info "%b")'
git_state='$(get_git_prompt_info "%s")'
PS1="[$PR_BLUE%n$PR_NO_COLOR@$PR_GREEN%U%m%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
RPS1="($PR_GREEN$git_br$PR_RED$git_state$PR_NO_COLOR)"
