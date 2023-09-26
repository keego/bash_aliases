#!/bin/bash

copy-from-home () {
  if [ -e ~/"$1" ] ; then
    rm -r ./"$1"
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
copy-from-home .hyper.js
copy-from-home .ripgrep
copy-from-home .tmux.conf
echo "...done!"
echo
