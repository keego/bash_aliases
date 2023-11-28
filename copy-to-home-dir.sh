#!/bin/bash

set -e

CACHE_DIR="./tmp-cache"

setup-cache () {
  if [ -e "$CACHE_DIR" ] ; then
   rm -r "$CACHE_DIR"
  fi
  mkdir "$CACHE_DIR"
  echo " (caching old home files to $CACHE_DIR)"
}

copy-to-home () {
  if [ -e ./"$1" ] ; then
    # cache before overwriting
    cp -r ~/"$1" "$CACHE_DIR/$1"
    # remove and copy

    # if the source and destination aren't both files or directories
    # then delete the destination to prevent copying from failing
    if [ "$(file -b ~/$1)" != "$(file -b ./$1)" ] ; then
      rm -r ~/"$1"
    fi
    cp -vr ./"$1" ~/
  else
    echo "skipping" ~/"$1"
  fi
}

echo "pushing files to home dir..."
setup-cache
echo
copy-to-home .bash_aliases
copy-to-home .bash_env
copy-to-home .bash_profile
copy-to-home .bash_ps1
copy-to-home .hyper.js
copy-to-home .ripgrep
copy-to-home .tmux.conf
echo "...done!"
echo
