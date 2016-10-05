# Syntax Notes
#
# for some command _x_:
# _x_1 = 1 layer deep
# _x_c = color mode
# _x_i = ignoring case
# _x_e = exclude

# Terminal
alias editprofile="subl ~/.bash_profile"
alias editaliases="subl ~/.bash_aliases"
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
alias lookforc="find . | grep -i --color=always"alias lsc="ls -FG"
alias lsc="ls -FG"

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

# Utilities
# syntax: countlines <regex to include> [<regex to exclude>]
function countlines () { find . | grep -iE --color=never $1 | grep -v --color=never ${2:-"^$"} | xargs wc -l | grep -iE --color=always "$1|(.*total$)"; }
# syntax: code <dir or file>
function code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*; }
# syntax: lookfore[c] <regex to include> [<regex to exclude>]
function lookfore() { find . | grep -viE "${2:-"^$"}" | grep -iE "$1" ; }
function lookforec() { find . | grep -viE "${2:-"^$"}" | grep -iE "$1" --color=always ; }
