#!/bin/bash

echo "interactively copying files..."
cp -iv .bash_aliases ~/
cp -iv .bash_aliases_private ~/
cp -iv .bash_env ~/
cp -iv .bash_profile ~/
cp -iv .bash_ps1 ~/
cp -iv .tmux.conf ~/
echo "...done!"
echo
