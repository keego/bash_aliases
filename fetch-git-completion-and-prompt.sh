#!/bin/bash

# grab files
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > .git-completion.bash
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh > .git-completion.zsh
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > .git-prompt.sh

# move them to ~, prompting to continue on overwrite
mv -i .git-completion.bash ~
mkdir ~/.zsh
mv -i .git-completion.zsh ~/.zsh/git
mv -i .git-prompt.sh ~
