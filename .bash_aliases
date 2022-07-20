
# open with default editor, defined by `EDIT` in your env, falling back to `open`
edit () { ${EDIT:-'code'} "$@" ; }

# MacOS

# control whether the OS GUI shows hidden files
alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
set-computer-name () {
  scutil --set ComputerName "$1" &&
  scutil --set HostName "$1"
}

# Terminal

alias edit-bash="edit ~/.bash*"
alias edit-aliases="edit ~/.bash_aliases"
alias edit-env="edit ~/.bash_env"
alias edit-private="edit ~/.bash_private"
alias edit-profile="edit ~/.bash_profile"
alias edit-bash-all="edit ~/.bash*"
alias reprofile="VERBOSE_REPROFILE=true source ~/.bash_profile"
alias realias="source ~/.bash_aliases"

# Bash

alias cdc='pwd | pbcopy'
alias cdp='cd $(pbpaste)'
alias grepc="grep -iE --color=always"
alias grepv="grep -viE"
alias lookfor="find . | grep -iE"
alias lookforc="find . | grepc"
alias lookfor1="find . -maxdepth 1 | grep -iE"
alias lookfor1c="find . -maxdepth 1 | grepc"
alias lookfor2="find . -maxdepth 2 | grep -iE"
alias lookfor2c="find . -maxdepth 2 | grepc"
alias lookfor3="find . -maxdepth 3 | grep -iE"
alias lookfor3c="find . -maxdepth 3 | grepc"
alias lookfor4="find . -maxdepth 4 | grep -iE"
alias lookfor4c="find . -maxdepth 4 | grepc"
alias lsc="ls -FG"

space() { n=${1-15} ; for i in $(seq $n); do echo ; done }

# Utilities

# syntax: countlines <regex to include> [<regex to exclude>]
countlines () { find . | grep -iE --color=never $1 | grep -v --color=never ${2:-"^$"} | xargs wc -l | grep -iE --color=always "$1|(.*total$)"; }
echo-run () {
  echo $@
  "$@"
}

# alias ytdlmp3="youtube-dl --extract-audio --audio-format mp3 --output \"%(title)s.%(ext)s\""
# alias ytdl="youtube-dl --output \"%(title)s.%(ext)s\""
# trim video from start time to start time + duration
# ffmpeg -i "input-file.mkv" -ss "HH:MM:SS.00" -t "HH:MM:SS.00" "output.mkv"
# use vlc's file > convert option to convert to mp3

# SSH

ssh-keygen-ed25519 () {
  if [[ $# -ne 2 ]]; then
    echo "Usage: ssh-keygen-ed25519 id_privatekey_name my.email@gmail.com" >&2
    return 2
  fi
  local KEY_NAME=$1
  local EMAIL=$2
  ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/$KEY_NAME -C “$EMAIL @ $HOSTNAME”
}

# VS Code

alias edit-snippets="edit ~/Library/Application\ Support/Code/User/Snippets"
alias edit-vscode-settings="edit ~/.Library/Application\ Support/Code/User/settings.json"

# Git

in-git-repo () ( git status &> /dev/null; [ $? -eq 0 ]; )
not-in-git-repo () ( git status &> /dev/null; [ $? -ne 0 ]; )
get-git-scope () { if in-git-repo; then echo '--local' ; else echo '--global' ; fi  }

# git set user
gsu () {
  if [[ $# -ne 3 ]]; then
    echo "Usage: git-set-user id_privatekey_name \"Full Name\" my.email@gmail.com" >&2
    return 2
  fi
  local KEY_FILE=~/.ssh/$1
  local NAME=$2
  local EMAIL=$3
  local SCOPE=$(get-git-scope)
  # echo-run git config $SCOPE core.sshCommand "ssh -i $KEY_FILE"
  echo-run ssh-add -D
  echo-run ssh-add $KEY_FILE
  echo-run git config $SCOPE user.name "$NAME"
  echo-run git config $SCOPE user.email "$EMAIL"
}

# check which ssh key is used for git clone, cloned repo is thrown away
gclone-check-key () {
  local FOLDER="/tmp/clone-check"
  if [[ -e $FOLDER ]]; then
    echo-run rm -rf $FOLDER
  fi
  (
    GIT_SSH_COMMAND="$(git config --get core.sshCommand) -v" git clone "$1" $FOLDER 2>&1 | grepc Offering
  )
}

# check which ssh key is used for git fetch
gfetch-check-key () {
  (
    GIT_SSH_COMMAND="$(git config --get core.sshCommand) -v" git fetch 2>&1 | grepc Offering
  )
}

gconfig () {
  if [[ $# -ne 0 ]]; then
    git config --list --show-origin | grepc $@
  else
    git config --list --show-origin
  fi
}

alias ga='git add'
alias gaa='git add -A && git status'

alias gb='git branch'
alias gbuoh='git branch -u origin/$(grph)'
gbdoh () {
  BRANCH="$(grph)"
  git checkout HEAD --detach --quiet
  echo
  echo "deleting remote $BRANCH ..."
  git push origin --delete "$BRANCH"
  echo
  echo "deleting local $BRANCH ..."
  git branch -d $BRANCH
}

alias gc='git commit'
alias gcane='git commit --amend --no-edit'
alias gcanenv='gcane --no-verify'
alias gch='git checkout'
alias gcm='git commit -m'
alias gcmwip='git add -A && git commit -m "WIP" --no-verify'

alias gd='git diff'
alias gdns='git diff  --name-status'
alias gdnscc="gdns | cut -f 2 | xargs code"
alias gdhns='git diff HEAD~ HEAD --name-status'
alias gdi='git diff --ignore-space-at-eol'
alias gdwc='echo " " +$(git diff | grep -e "^[+][^+]" | wc -l) -$(git diff | grep -e "^[-][^-]" | wc -l)'
alias gdswc='echo " " +$(git diff --staged | grep -e "^[+][^+]" | wc -l) -$(git diff --staged | grep -e "^[-][^-]" | wc -l)'

alias gf='git fetch --all --prune'
alias gfom='git fetch origin master:master'

alias gl='git log --decorate --abbrev-commit'
alias glg='git log --decorate --abbrev-commit --graph'
alias glgp='git log --decorate --abbrev-commit --graph --pretty=oneline'
alias glp='git log --decorate --abbrev-commit --pretty=oneline'
alias glt='git log --pretty="%C(auto)[ Authored %ad -- Committed %cd ] %h %d %s" --date=local'

alias gpullohr='glp -5 && git pull origin $(grph) --rebase'
alias gpullom='git pull origin master'
alias gpullomd='gch HEAD --detach && git fetch origin master:master && gch master'
alias gpushoh='git push origin $(grph)'
alias grph='git rev-parse --abbrev-ref HEAD'
alias grphc='echo $(git rev-parse --abbrev-ref HEAD) | pbcopy'

alias gs='git status'
alias gsa='git stash apply'
alias gsl='git stash list'
alias gss='git stash save'
alias gsedit='git status | grep "\t" | cut -d":" -f 2- | edit'

gcht() { git fetch "$1" "$2" && git checkout -t "$1/$2"; }
git-amend-current-commit-date() { GIT_COMMITTER_DATE="$1" git commit --amend --date="$1" --no-edit ; }
git-view-changes() { FROM="$1" ; TO="$2" ; git checkout $TO && git reset $FROM --soft ; }
code-review() { BRANCH="$1" ; git fetch origin master && git checkout code-review && git reset $BRANCH --hard && git reset origin/master --soft ; }
