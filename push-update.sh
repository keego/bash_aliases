#!/bin/bash

NOW=$(date '+%Y-%m-%d %H:%M:%S')
NOW_BRRANCH="update-$(date '+%Y-%m-%d--%H-%M-%S')"

git add -A &&
git checkout -b "$NOW_BRRANCH" &&
git commit -m "Updating as of $NOW" --allow-empty &&
git push origin "$NOW_BRRANCH" &&
open "https://github.com/keego/bash_aliases/pull/new/$NOW_BRRANCH"
