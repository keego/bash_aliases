#!/bin/bash

NOW=$(date '+%Y-%m-%d %H:%M:%S')
NOW_BRRANCH="update-$(date '+%Y-%m-%d--%H-%M-%S')"

git add -A

STAGED_CHANGES=$(git status | tail -n +4)

git checkout -b "$NOW_BRRANCH" &&
echo &&

git commit -m "Updating as of $NOW
$STAGED_CHANGES" --allow-empty

echo &&
git push origin "$NOW_BRRANCH" &&

echo &&
open "https://github.com/keego/bash_aliases/pull/new/$NOW_BRRANCH"
