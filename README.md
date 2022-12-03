# Dotfiles

### not my actual dotfiles, just a quick upload for a friend to point at some config points

should probably de-corpicize the real repo and put it on here


### How to use this

So, the script [make_links] (make_links.sh) will scan through whatever folder it is in and set up softlinks for any of the following files:

aliases, bashrc, zshrc, neovimrc, bash_profile, etc

the goal is to keep all your dotfiles in a folder called ~/dotfiles, then run make_links.sh and let it populate

it will put neovimrc in ~/.config/neovim/init.vim, where neovim looks for it.

Soon it'll do the same for vimrc.

It will also install git-completions.bash and git-prompt.sh to ~/.completions, and git-completions.zsh will be saved in the same spot and called `_git`

The preferred method of using this is to clone the repo, erase anything you don't need, drop your dotfiles in minus the dot and run ./make_links.sh

should just work. Don't email me if it doesn't

credit for git-completion.* is from [here](https://github.com/git/git/tree/master/contrib/completion)
