#!/bin/bash

set -e

CODE_SUCCESS=10
CODE_SKIP=20

get-exit-symbol () {
  local exit_code=$1
  local symbol="$2"

  case $exit_code in
    $CODE_SUCCESS )
      echo -n "$Green $symbol $Color_Off" ;;
    $CODE_SKIP )
      echo -n "$Yellow $symbol $Color_Off" ;;
    * )
      echo -n "$Red $symbol $Color_Off" ;;
  esac
}

clean-local-path () {
  local path="$1"
  if [ -e ./"$path" ] ; then
    rm -r ./"$path"
    echo $CODE_SUCCESS
  else
    echo $CODE_SKIP
  fi
}

update-local-path () {
  local path="$1"
  if [ -e ~/"$path" ] ; then
    cp -r ~/"$path" ./
    echo $CODE_SUCCESS
  else
    echo $CODE_SKIP
  fi
}

copy-from-home () {
  local path="$1"
  if [ -e ./"$path" ] ; then
    get-exit-symbol $(clean-local-path "$path") clean
    get-exit-symbol $(update-local-path "$path") update
  else
    get-exit-symbol $CODE_SKIP clean
    get-exit-symbol $CODE_SKIP update
  fi
  echo " $path"
}

echo "pulling files from home dir..."
echo
copy-from-home .bash_aliases
copy-from-home .bash_colors
copy-from-home .bash_env
copy-from-home .bash_profile
copy-from-home .bash_ps1
copy-from-home .bashrc
copy-from-home .hyper.js
copy-from-home .ripgrep
copy-from-home .tmux.conf
echo
echo "...done!"
echo
