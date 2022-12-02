#!/bin/bash
file_location=$(dirname $0)
echo -e $file_location	
for file in bashrc,path,exports,aliases,functions,extra,secrets,bash_profile,zshrc; do
    [[ -f $file_location/$file ]] && ln -s $file_location/$file ~/.$file
done

[[ -f ~/zsh ]] || mkdir ~/zsh

## install/update zsh git-completions
echo -e "Installing git-completion.zsh as ~/.zsh/_git"
curl  -o ~/.zsh/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

# install the rest of the fleet
echo -e "Installing/Updating .git-completion.bash, and .git-prompt.sh in ~"
curl -o ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash --silent
curl -o ~/.git-completion.zsh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh --silent
curl  -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh --silent


