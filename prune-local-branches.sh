#!/bin/bash

#
# Prune local branches that have been deleted from the remote repository
#

echo "Pruning local branches that have been deleted from the remote repository..."

echo
echo "branches before pruning:"
git branch

# delete all local branches that have been deleted from the remote repository
git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D

# delete all local update branches
# git fetch -p && git branch -vv | awk '/update/{print $1}' | grep -v "*" |  xargs git branch -D

echo
echo "branches after pruning:"
git branch


echo "...done"

