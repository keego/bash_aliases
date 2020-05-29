# bash_aliases

A simple collection of bash profiles and other config files that enhance my dev environment via aliases, a nice git-status prompt, and some tmux settings.

## usage

1. Download git completion and move it to your home dir.

   `./fetch-git-completion-and-prompt.sh`

2. Copy files to your home dir.

   `./copy-to-home-dir.sh`

   Don't worry it'll ask before overwriting.

   Alternatively you can just manually `cp -i <some_file> ~/` to manually copy any .bash_xxx or other config to your home dir.

3. Either `source ~/.bash_profile` or just open a new terminal

From here on out you can simply `reprofile` to `source ~/.bash_profile`

## contributing

From this repo you can run `./copy-from-home-dir.sh` to copy (interactively) a whitelisted set of settings files into this repo.

As mentioned in the [usage](#usage) section, you can `./copy-to-home-dir.sh` to copy common settings files from this repo to your home dir. Coupled with `reprofile`ing this can allow for rapid development and testing.

When you're ready to submit your changes, go ahead and `./push-update.sh` to automatically pack up your local changes and kickstart opening a PR to the repo.

## git-completion

Some of these files depend on git-completion.bash and git-prompt.sh from git's source code. Instead of adding a rather large and unnecessary submodule to this project, I just wrote a simple script to curl the 2 files to this directory and move them under your home dir :)
