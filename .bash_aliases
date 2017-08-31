# Syntax Notes
#
# for some command _x_:
# _x_1 = 1 layer deep
# _x_c = color mode
# _x_i = ignoring case
# _x_e = exclude

# Colors
export ColorReset=$'\033[0m'
export Blue=$'\033[0;34m'
export Black=$'\033[0;30m'
export Red=$'\033[0;31m'
export Green=$'\033[0;32m'
export Yellow=$'\033[0;33m'
export Blue=$'\033[0;34m'
export Purple=$'\033[0;35m'
export Cyan=$'\033[0;36m'
export White=$'\033[0;37m'

# Terminal
alias editprofile="atom ~/.bash_profile"
alias editaliases="atom ~/.bash_aliases"
alias showaliases="cat ~/.bash_aliases"
alias reload="source ~/.bash_profile"
alias realias="source ~/.bash_aliases"

# control whether the OS GUI shows hidden files
alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Bash
alias grepc="grep --color=always"
alias lookfor="find . | grep -i"
alias lookfor1="find . -maxdepth 1 | grep -i"
alias lookforc="find . | grep -i --color=always"
# alias lsc="ls -FG"
function colorize() { echo "${@:2}" | xargs -I {} echo ${!1}{}$ColorReset ; }
export -f colorize
function ls-lined() { ls -F | xargs -L 1 echo ; }
function ls-lined-folders() { ls-lined | grep -iE '[/]$' ; }
function ls-lined-folders-c() { ls-lined-folders | xargs -I {} bash -c 'colorize Blue {}' ; }
function ls-lined-files() { ls-lined | grep -iE '[a-zA-Z0-9]$' ; }
function ls-lined-files-c() { ls-lined-files | xargs -I {} bash -c 'colorize White {}' ; }
function ls-lined-executables() { ls-lined | grep -iE '[*]$' ; }
function ls-lined-executables-c() { ls-lined-executables | xargs -I {} bash -c 'colorize Green {}' ; }
alias lsc="ls-lined-folders-c && ls-lined-files-c && ls-lined-executables-c"

# Git
alias ga="git add"
alias gaa="git add --all . && git status"
alias gb="git branch"
alias gc="git commit"
alias gcm="git commit -m"
alias gcane="git commit --amend --no-edit"
alias gch="git checkout"
alias gd="git diff"
alias gdi="git diff --ignore-space-at-eol"
alias gf="git fetch --all --prune"
alias gs="git status"
alias gl="git log --decorate --abbrev-commit"
alias glp="git log --decorate --abbrev-commit --pretty=oneline"
alias glg="git log --decorate --abbrev-commit --graph"
alias gsa="git stash apply"
alias gsl="git stash list"
alias gss="git stash save"
function git-amend-current-commit-date() { GIT_COMMITTER_DATE="$1" git commit --amend --date="$1" --no-edit ; }
function git-view-changes() { FROM="$1" ; TO="$2" ; git checkout $TO && git reset $FROM --soft ; }
function code-review() { BRANCH="$1" ; git checkout code-review && git reset $BRANCH --hard && git reset origin/develop/0.0.0/stable --soft ; }

# Server
alias start-server="sudo apachectl start"
alias stop-server="sudo apachectl stop"
alias restart-server="sudo apachectl stop && sudo apachectl start"

# Utilities
# syntax: countlines <regex to include> [<regex to exclude>]
function countlines () { find . | grep -iE --color=never $1 | grep -v --color=never ${2:-"^$"} | xargs wc -l | grep -iE --color=always "$1|(.*total$)"; }
# syntax: code <dir or file>
function code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*; }
# syntax: lookfore[c] <regex to include> [<regex to exclude>]
function lookfore() { find . | grep -viE "${2:-"^$"}" | grep -iE "$1" ; }
function lookforec() { find . | grep -viE "${2:-"^$"}" | grep -iE "$1" --color=always ; }

# Xcode
alias clear-derived-data="rm -r ~/Library/Developer/Xcode/DerivedData"
