#!/usr/bin/env bash
#-------------------------------------------------------
#   Rakefile - Overview
#-------------------------------------------------------
#   This is the shell-based method to install dotfiles.
#   This does the exact same thing as the Rakefile, but
#   is primarily intended for those who do not have
#   access to Ruby on their system.

#--------------------------------------------------
#   Function to regenerate .gitconfig and place it
#   in the user's home directory
#--------------------------------------------------
gitconfig_setup()
{
  name=$(git config --global user.name)
  email=$(git config --global user.email)
  
  if [ -a ${HOME}/.gitconfig ]; then
    rm ${HOME}/.gitconfig
    cp ${PWD}/gitconfig ${HOME}/.gitconfig
  else
    cp ${PWD}/gitconfig ${HOME}/.gitconfig
  fi
  
  read -p "Git Name (leave blank to default to '${name}'): " new_name
  read -p "Git Email (leave blank to default to '${email}'): " new_email
  
  if [ -z "$new_name" ]; then
    git config --global user.name "${name}"
  else
    git config --global user.name "${new_name}"
  fi
  
  if [ -z "$new_email" ]; then
    git config --global user.email "${email}"
  else
    git config --global user.email "${new_email}"
  fi
  
  git config --global core.excludesfile ~/.gitignore
}

#--------------------------------------------------
#   If the user simply runs `./install.sh`, display
#   the possible options
#--------------------------------------------------
help_message()
{
  echo "Usage: ./install.sh [option]"
  echo "Possible options: install, gc"
}

#--------------------------------------------------
#   Function to determine whether a given entry
#   exists in an array
#--------------------------------------------------
in_array()
{
  haystack=( "$@" )
  haystack_size=( "${#haystack[@]}" )
  needle=${haystack[$((${haystack_size}-1))]}
  for ((i=0;i<$(($haystack_size-1));i++)); do
    h=${haystack[${i}]};
    [ $h = $needle ] && return 0
  done
}

#--------------------------------------------------
#   Creates a symbolically linked "." version of a
#   file in the user's home directory
#--------------------------------------------------
link_file()
{
  echo "Linking ~/.${1}..."
  ln -s ${PWD}/${1} ${HOME}/.${1}
}

#--------------------------------------------------
#   Replaces a "." symlink in the user's home 
#   directory
#--------------------------------------------------
replace_file()
{
  echo "Removing old ~/.${1}..."
  rm ${HOME}/.${1}
  link_file $1
}

#--------------------------------------------------
#   Main program
#--------------------------------------------------
if [ $# -ne 1 ] || [ $1 == "-h" ] || [ $1 == "--help" ]; then
  help_message
else
  case $1 in
    install)
      replace_all=false
      copied_files=(gitignore zshrc)
      for i in *
      do
        file=$i
        [[ $file =~ .*~$ ]] && continue
        in_array "${copied_files[@]}" "$i"
        if [ $? -eq 0 ]; then
          if [ -a ${HOME}/.${file} ]; then
            if $replace_all; then
              replace_file $file
            else
              read -p "Overwrite ~/.${file}? [yNaq]: " response
              case $response in
                a) replace_all=true
                   replace_file $file;;
                y) replace_file $file;;
                q) exit;;
                *) echo "Skipping ~/.${file}";;
              esac
            fi
          else
            link_file $file
          fi
        fi
      done;
      gitconfig_setup;;
    gc) gitconfig_setup;;
    *)  help_message;;
  esac
fi
