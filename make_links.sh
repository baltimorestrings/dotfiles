#!/bin/bash
is_mac=false
[[ `uname` == "Darwin" ]] && is_mac == true

path_to_this_file="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")" 
dotfiles_folder=$(dirname $path_to_this_file)
completions_and_prompt_folder="$HOME/.completions"

echo -e Using "$dotfiles_folder" as dotfiles folder

# for every file in this list, make a ~/.#$file:
for file in bashrc path exports aliases functions extra secrets bash_profile zshrc; do
    if [[ -f $dotfiles_folder/$file ]]; then
        echo -e "found $file in dotfiles, creating ~/.$file"
        rm -rf ~/.$file
        ln -s $dotfiles_folder/$file $HOME/.$file
    fi
done

# install neovim if not present
which nvim &>/dev/null || sudo yum install -y neovim --enablerepo=epel || brew install neovim

# set up vimplug
~/.local/share/nvim/plugged
# set up neovim-style RC, if detected
if [[ -f $dotfiles_folder/neovimrc ]]; then
    echo -e "installing discovered file neovimrc"
    mkdir -p ~/.config/nvim &>/dev/null
    rm ~/.config/nvim/init.vim &>/dev/null
    ln -s $dotfiles_folder/neovimrc $HOME/.config/nvim/init.vim
fi

# set up vim.plug in the neovim autoload dir
nvim_autoload_dir="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
if [[ -f $nvim_autoload_dir ]]; then
    echo vim.plug already detected
else
    echo installing vim-plug to $nvim_autoload_dir
    sh -c 'curl -sfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo next time you open nvim, please run :PlugInstall, then :PlugUpdate
fi

# clean up old attempts
rm -rf ~/.zsh ~zsh &>/dev/null

# make folder for zsh completions:
mkdir $completions_and_prompt_folder &>/dev/null

## install/update zsh git-completions
echo -e "Installing git-completion.zsh as $completions_and_prompt_folder/_git"
curl  -so $completions_and_prompt_folder/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

# install the rest of the fleet
echo -e "Installing/Updating git-completion.bash (still needed for ZSH completions) and git-prompt.sh in $completions_and_prompt_folder"
curl -so $completions_and_prompt_folder/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash 
curl  -so $completions_and_prompt_folder/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh 
