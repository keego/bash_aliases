# bash_aliases
A simple collection of bash profiles and other config files that enhance my dev environment via aliases, a nice git-status prompt, and some tmux settings.

## usage
1. `./fetch-git-completion-and-prompt.sh` (download git completion and move it to your home dir)
2. `cp <some_file> ~/` (copy any .bash_xxx or other config to your home dir)
3. either `source ~/.bash_profile` or just open a new terminal

## git-completion
Some of these files depend on git-completion.bash and git-prompt.sh from git's source code. Instead of adding a rather large and unnecessary submodule to this project, I just wrote a simple script to curl the 2 files to this directory and move them under your home dir :)

