#!/bin/bash

copy-to-home () {
  if [ -e ./"$1" ] ; then
    cp -ivr ./"$1" ~/
  else
    echo "skipping" ~/"$1"
  fi
  echo
}

echo "interactively copying files..."
echo
copy-to-home .bash_aliases
copy-to-home .bash_env
copy-to-home .bash_profile
copy-to-home .bash_ps1
copy-to-home .tmux.conf
echo "...done!"
echo
