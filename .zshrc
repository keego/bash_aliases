#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O

# As per https://stackoverflow.com/a/34252007/3234235
# - use \001 and \002 for RL_PROMPT_START_IGNORE and RL_PROMPT_END_IGNORE respectively
#   (i.e. prevent fucking up cursors and scrolling)
# - use \033 over \e for portability
set-color () {
  local special=$1
  local color=$2

  echo -e "\001\033[${special};${color}m\002"
}

# Reset
Color_Off="$(set-color  0 0)"     # Text Reset

# Blink
Blink="$(set-color      0 5)"     # Blinking text
Blink_Off="$(set-color  0 25)"     # Removes blinking text

# Regular Colors
Black="$(set-color      0 30)"    # Black
Red="$(set-color        0 31)"    # Red
Green="$(set-color      0 32)"    # Green
Yellow="$(set-color     0 33)"    # Yellow
Blue="$(set-color       0 34)"    # Blue
Purple="$(set-color     0 35)"    # Purple
Cyan="$(set-color       0 36)"    # Cyan
White="$(set-color      0 37)"    # White

# Bold
BBlack="$(set-color     1 30)"    # Black
BRed="$(set-color       1 31)"    # Red
BGreen="$(set-color     1 32)"    # Green
BYellow="$(set-color    1 33)"    # Yellow
BBlue="$(set-color      1 34)"    # Blue
BPurple="$(set-color    1 35)"    # Purple
BCyan="$(set-color      1 36)"    # Cyan
BWhite="$(set-color     1 37)"    # White

# Underline
UBlack="$(set-color     4 30)"    # Black
URed="$(set-color       4 31)"    # Red
UGreen="$(set-color     4 32)"    # Green
UYellow="$(set-color    4 33)"    # Yellow
UBlue="$(set-color      4 34)"    # Blue
UPurple="$(set-color    4 35)"    # Purple
UCyan="$(set-color      4 36)"    # Cyan
UWhite="$(set-color     4 37)"    # White

# Background
On_Black="$(set-color   0 40)"    # Black
On_Red="$(set-color     0 41)"    # Red
On_Green="$(set-color   0 42)"    # Green
On_Yellow="$(set-color  0 43)"    # Yellow
On_Blue="$(set-color    0 44)"    # Blue
On_Purple="$(set-color  0 45)"    # Purple
On_Cyan="$(set-color    0 46)"    # Cyan
On_White="$(set-color   0 47)"    # White

# High Intensty
IBlack="$(set-color     0 90)"    # Black
IRed="$(set-color       0 91)"    # Red
IGreen="$(set-color     0 92)"    # Green
IYellow="$(set-color    0 93)"    # Yellow
IBlue="$(set-color      0 94)"    # Blue
IPurple="$(set-color    0 95)"    # Purple
ICyan="$(set-color      0 96)"    # Cyan
IWhite="$(set-color     0 97)"    # White

# Bold High Intensty
BIBlack="$(set-color    1 90)"    # Black
BIRed="$(set-color      1 91)"    # Red
BIGreen="$(set-color    1 92)"    # Green
BIYellow="$(set-color   1 93)"    # Yellow
BIBlue="$(set-color     1 94)"    # Blue
BIPurple="$(set-color   1 95)"    # Purple
BICyan="$(set-color     1 96)"    # Cyan
BIWhite="$(set-color    1 97)"    # White

# High Intensty backgrounds
On_IBlack="$(set-color  0 100)"   # Black
On_IRed="$(set-color    0 101)"   # Red
On_IGreen="$(set-color  0 102)"   # Green
On_IYellow="$(set-color 0 103)"   # Yellow
On_IBlue="$(set-color   0 104)"   # Blue
On_IPurple="$(set-color 0 105)"   # Purple
On_ICyan="$(set-color   0 106)"   # Cyan
On_IWhite="$(set-color  0 107)"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\W"
PathFull="\w"
NewLine="\n"
Jobs="\j"
PromptSymbol="$Green>$Color_Off"
SuPromptSymbol="$Green"'%%'"$Color_Off"
ShellName="$0"

command_exists () {
  type "$1" > /dev/null 2>&1 ;
}

if command_exists scutil ; then
  # OS X
  COMPUTER_NAME="$(scutil --get ComputerName)"
else
  # Standard
  COMPUTER_NAME="\h"
fi

# source files in ~/.zsh folder
fpath=(~/.zsh $fpath)

# git-completion.bash is also needed, this tells zsh where it is
zstyle ':completion:*:*:git:*' script ~/.git-completion.bash

source ~/.git-prompt.sh

# This PS1 snippet was adopted from code for MAC/BSD from: http://allancraig.net/index.php?option=com_content&view=article&id=108:ps1-export-command-for-git&catid=45:general&Itemid=96
# It was tweaked to work on UBUNTU 11.04 & 11.10 and be mo' better

parse-git-branch () {
  local path_short="$Blue%1d$Color_Off"
  local path_full="$Yellow%~$Color_Off"

  git branch &>/dev/null
  if [ $? -eq 0 ]; then 
    echo `git status` | grep "nothing to commit" > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
      # @4 - Clean repository - nothing to commit
      echo -n "$Green$(__git_ps1 " (%s)")$Color_Off"
    else
      # @5 - Changes to working tree
      echo -n "$IRed$(__git_ps1 " {%s}")$Color_Off"
    fi
    echo " $path_short "
  else \
    # @2 - Prompt when not in GIT repo
    echo " $path_full "
  fi
}

set-ps1 () {
  local comp_color="$1"
  local comp_name="$comp_color%m$Color_Off"
  local user_name="$IBlack(%n)$Color_Off"
  local shell_cmd="$IBlack$ShellName$Color_Off"
  local time="$IBlack"'$(date "+%r")'"$Color_Off"
  local exit_symbol="%(?.$Green.$Red)? %?$Color_Off"
  local prompt_symbol="%(!.$SuPromptSymbol.$PromptSymbol)"

  PS1=''
  PS1+=$'\n'"$comp_name $user_name $shell_cmd"
  PS1+=$'\n'"$time $(parse-git-branch)"
  PS1+=$'\n'"$exit_symbol $prompt_symbol "
}

setopt PROMPT_SUBST

set-ps1 $Yellow
