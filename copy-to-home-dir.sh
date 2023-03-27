#!/bin/bash

copy-to-home () {
  if [ -e ./"$1" ] ; then
    # if the source and destination aren't both files or directories
    # then delete the destination to prevent copying from failing
    if [ "$(file -b ~/$1)" != "$(file -b ./$1)" ] ; then
      rm -r ~/"$1"
    fi
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
copy-to-home .hyper.js
echo "...done!"
echo
