# Quick Instructions

For the purpose of these instructions, I'm assuming all the files git-completions.bash, git-completions.zsh, git-prompt.sh exist in a folder called dotfiles in your home folder.

1) Your ~/.zshrc will have to `source` git-completions.bash and add an fpath directive
  - Add the following lines to your ~/.zshrc:
    ```bash
    source ~/dotfiles/git-completion.bash
    fpath=(~/.zsh $fpath)
    zstyle ':completion:*:*:git:*' script ~/dotfiles/git-completion.bash
    ```

  
2) Create a folder name .zsh in your home directory:
  ```bash
  mkdir ~/.zsh
  ```
  
3) create a link (or copy file) to ~/dotfiles/git-completions.zsh, BUT IT MUST BE CALLED _git
  ```bash
  ln -s ~/dotfiles/git-prompt.sh ~/.zsh/_git
  ```
  
  
