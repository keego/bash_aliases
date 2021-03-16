#!/bin/bash

copy-from-home () {
  if [ -e ~/"$1" ] ; then
    cp -ivr ~/"$1" ./
  else
    echo "skipping" ~/"$1"
  fi
  echo
}

echo "interactively copying files..."
echo
copy-from-home .bash_aliases
copy-from-home .bash_env
copy-from-home .bash_profile
copy-from-home .bash_ps1
copy-from-home .tmux.conf
copy-from-home .hyper.js
echo "...done!"
echo
