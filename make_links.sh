#!/bin/bash

######## functions ############################################################################

function is_installed() {
    # is_installed <progname> will return true if progname is installed
    which $1 &>/dev/null;
    return;
}

function is_mac() {
    # is_mac will return true if we're running on a mac
    [ $(uname) == "Darwin" ]
    return
}

function get_this_file_path() {
    # posix grossness. This'll return file path on any _nix machine
    echo -e $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")
}

######## configuration/setup ############################################################################

VIMPLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    # https://github.com/junegunn/vim-plug has full install instructions

FILES_TO_DOTFILE=(bashrc path exports aliases functions extra secrets bash_profile zshrc vimrc)
    # every one of these that this script sees in the same folder as itself, it'll make a dotfile softlink

COMPLETIONS_AND_PROMPT_FOLDER="$HOME/.completions"
    # this is where we will install git-{prompt,completion}.{sh,zsh,bash}

path_to_this_file=$(get_this_file_path)
dotfiles_folder=$(dirname $path_to_this_file)
    # store up some path vars

echo -e Using "$dotfiles_folder" as dotfiles folder

####### dotfile creation #####################################################################

for file in "{FILES_TO_DOTFILE[@]}"; do
    # sort through every file type we wwanna dotfile

    if [[ -f $dotfiles_folder/$file ]]; then
        echo -e "found $file in dotfiles, creating ~/.$file"
        [[ -f ~/.$file ]] && mv "~/.$file" "~/.$file.dotfiler.bak"
            # if we found one, take a backup if a dotfile already exists in the home dir

        ln -s $dotfiles_folder/$file $HOME/.$file
            # and softlink away
    fi
done

[[ `id -u` == 0 ]] && ln -s /root/.bash_profile /root/.bashrc
    # if we're root, symlink /root/.profile to /root/.bashrc to support non-login shells

###### install neovim ######################################################################

which nvim &>/dev/null || \
( 
    echo "installing neovim, may take a sec..." \
    && is_installed yum && sudo yum install -y neovim --enablerepo=epel  \
   || brew install neovim &>/dev/null \
)

# set up vimplug in the neovim autoload dir:
~/.local/share/nvim/plugged

if [[ -f $dotfiles_folder/neovimrc ]]; then
    # set up neovim-style RC, if detected
    echo -e "installing discovered file neovimrc"
    mkdir -p ~/.config/nvim &>/dev/null
    rm ~/.config/nvim/init.vim &>/dev/null
    ln -s $dotfiles_folder/neovimrc $HOME/.config/nvim/init.vim
fi

nvim_autoload_dir="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/"
   # build our autoload dir for neovim 

if [[ -f $nvim_autoload_dir/vim.plug ]]; then
    echo vim.plug already installed
else
    mkdir -p "$nvim_autoload_dir" &>/dev/null
    echo installing vim-plug to "$nvim_autoload_dir/plug.vim"
    curl -s "$VIMPLUG_URL" > "$nvim_autoload_dir/plug.vim"
    echo next time you open nvim, please run :PlugInstall, then :PlugUpdate
fi
#
########## get vim dirs pointed at neovim dirs

mkdir ~/.vim &>/dev/null
    # ensure ~/.vim exists

[[ -f ~/.vim/autoload ]] || ln -s "$nvim_autoload_dir" ~/.vim/autoload
    # link ~/.vim/autoload to the neovim autoload dir

echo -e "ensured that there's a symlink of ~/.vim/autoload -> $nvim_autoload_dir"

# make folder for zsh completions:
mkdir $COMPLETIONS_AND_PROMPT_FOLDER &>/dev/null

## install/update zsh git-completions
echo -e "Installing git-completion.zsh as $COMPLETIONS_AND_PROMPT_FOLDER/_git"
curl  -s  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh > $COMPLETIONS_AND_PROMPT_FOLDER/_git

# install the rest of the fleet
echo -e "Installing/Updating git-completion.bash (still needed for ZSH completions) and git-prompt.sh in $COMPLETIONS_AND_PROMPT_FOLDER"
curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh  >  $COMPLETIONS_AND_PROMPT_FOLDER/git-prompt.sh
curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > $COMPLETIONS_AND_PROMPT_FOLDER/git-completion.bash 
