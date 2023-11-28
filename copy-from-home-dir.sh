#!/bin/bash

set -e

CACHE_DIR="./tmp-cache"

setup-cache () {
  if [ -e "$CACHE_DIR" ] ; then
   rm -r "$CACHE_DIR"
  fi
  mkdir "$CACHE_DIR"
  echo " (caching local files to $CACHE_DIR)"
}

copy-from-home () {
  if [ -e ~/"$1" ] ; then
    # cache before overwriting
    cp -r ./"$1" "$CACHE_DIR/$1"
    # remove and copy
    rm -r ./"$1"
    cp -vr ~/"$1" ./
  else
    echo "skipping" ~/"$1"
  fi
}

echo "pulling files from home dir..."
setup-cache
echo
copy-from-home .bash_aliases
copy-from-home .bash_env
copy-from-home .bash_profile
copy-from-home .bash_ps1
copy-from-home .hyper.js
copy-from-home .ripgrep
copy-from-home .tmux.conf
echo "...done!"
echo
