#!/bin/bash

set -e

source .bash_colors

CACHE_DIR="./tmp-cache"

CODE_SUCCESS=10
CODE_SKIP=20

setup-cache () {
  if [ -e "$CACHE_DIR" ] ; then
   rm -r "$CACHE_DIR"
  fi
  mkdir "$CACHE_DIR"
  echo " (caching old home files to $CACHE_DIR)"
}

proceed? () {
  while true ; do
    echo
    read -p "Do you want to proceed? (y/n) " yn

    case $yn in
      [yY] )
        break;;
      [nN] )
        echo "  exiting..."
        exit 1;;
      * )
        echo "  invalid response"
    esac
  done
}

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

cache-home-path () {
  local path="$1"
  if [ -e ~/"$path" ] ; then
    cp -r ~/"$path" "$CACHE_DIR/$path"
    echo $CODE_SUCCESS
  else
    echo $CODE_SKIP
  fi
}

clean-home-path () {
  local path="$1"
  if [ -e ~/"$path" ] ; then
    rm -r ~/"$path"
    echo $CODE_SUCCESS
  else
    echo $CODE_SKIP
  fi
}

update-home-path () {
  local path="$1"
  cp -r ./"$path" ~/
  echo $CODE_SUCCESS
}

copy-to-home () {
  local path="$1"
  if [ -e ./"$path" ] ; then
    get-exit-symbol $(cache-home-path "$path") cache
    get-exit-symbol $(clean-home-path "$path") clean
    get-exit-symbol $(update-home-path "$path") update
  else
    get-exit-symbol $CODE_SKIP cache
    get-exit-symbol $CODE_SKIP clean
    get-exit-symbol $CODE_SKIP update
  fi
  echo " $path"
}

warn-overwrite () {
  local filename="$1"
  local suggested_filepath="~/.bash_private/$2"

  if [ -e ./"$filename" ] ; then
    if [ -e ~/"$filename" ] ; then
      echo
      echo '~/'"$filename"' exists, this will be overwritten!'
      echo '  move this to '"$suggested_filepath"' if you wish to keep its contents'
      proceed?
    fi
  fi
}

echo
echo "pushing files to home dir..."
setup-cache
warn-overwrite .bashrc rc
warn-overwrite .bash_profile profile
echo
copy-to-home .bash_aliases
copy-to-home .bash_colors
copy-to-home .bash_env
copy-to-home .bash_profile
copy-to-home .bash_ps1
copy-to-home .bashrc
copy-to-home .hyper.js
copy-to-home .ripgrep
copy-to-home .tmux.conf
echo
echo "...done!"
echo
