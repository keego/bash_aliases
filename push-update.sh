#!/bin/bash

NOW=$(date '+%Y-%m-%d %H:%M:%S')
NOW_BRANCH="update-$(date '+%Y-%m-%d--%H-%M-%S')"

git add -A

STAGED_CHANGES=$(git status | tail -n +4)

git checkout -b "$NOW_BRANCH" &&
echo &&

git commit -m "Updating as of $NOW
$STAGED_CHANGES" --allow-empty

echo &&
git push origin "$NOW_BRANCH" &&

echo &&
open "https://github.com/keego/bash_aliases/pull/new/$NOW_BRANCH"
