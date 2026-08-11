#!/bin/bash

#
# Prune local branches that have been deleted from the remote repository
#

echo "Pruning local branches that have been deleted from the remote repository..."

echo "branches before pruning:"
git branch

# git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
git fetch -p && git branch -vv | awk '/update/{print $1}' | xargs -I {} echo git branch -D {}

echo "branches after pruning:"
git branch


echo "...done"

