#!/bin/bash

#
# Verify no uncommitted changes
#

echo `git status` | grep "nothing to commit" > /dev/null 2>&1
if [ "$?" -ne "0" ]; then
  # (changes to working tree)

  echo You have uncommitted changes.
  echo Please commit your changes with a meaningful message before pushing an update.
  exit 1
else
  # (clean repository - nothing to commit)
  echo "No uncommitted changes, great!"
fi

#
# Automatically open new PR
#

NOW=$(date '+%Y-%m-%d %H:%M:%S')
NOW_BRANCH="update-$(date '+%Y-%m-%d--%H-%M-%S')"
TITLE="Updating as of $NOW"
COMMIT_COUNT=`git rev-list --count origin/master..HEAD`
BODY=$'Changes:\n'
BODY+=`git log --no-decorate --abbrev-commit -${COMMIT_COUNT} --pretty='- (%h) %s'`

echo "Creating PR with info:"
echo "-----"
echo "$TITLE"
echo "$BODY"
echo "-----"

git checkout -b "$NOW_BRANCH" &&
echo &&

git push origin "$NOW_BRANCH" &&
echo &&

open "https://github.com/keego/bash_aliases/compare/master...$NOW_BRANCH?quick_pull=1&title=$TITLE&body=$BODY"
