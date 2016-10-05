SSH_ENV=$HOME/.ssh/environment
   
# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}
   
if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# Bash completion
if [ -f /etc/bash_completion ]; then
  /etc/bash_completion
fi

source ~/.git-prompt.sh

# Custom bash prompt via kirsle.net/wizards/ps1.html
function PS1 {
  YELLOW="$(tput setaf 3)"
  GREEN="$(tput setaf 2)"
  RESET="$(tput sgr0)"

  if [[ -d $(git rev-parse --show-toplevel 2>/dev/null) ]]; then
    # In a git repo
    GIT_CWD="git rev-parse --show-toplevel"
    GIT_ROOT="echo $(eval $GIT_CWD) | sed -r 's,^(.*)/[^/]*$,\1,'"
    export GIT_PS1_SHOWDIRTYSTATE=1
    PROMPT_PATH="pwd | sed -r 's,$(eval $GIT_ROOT)/?(.*),\1,'"
  else
    PROMPT_PATH="pwd | sed -r 's,^/cygdrive/?(.*),//\1,'"
  fi

  echo
  echo "$YELLOW$(eval $PROMPT_PATH)$GREEN$(__git_ps1 ' (%s)')$RESET"
  echo
}
export PROMPT_COMMAND=PS1
export PS1="\[$(tput setaf 2)\]$\[\$(tput sgr0)\] "

source ~/.bash_aliases
