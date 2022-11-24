ZSH_AUTOSUGGEST_USE_ASYNC=1
echo "Users/baltiomrestrings/.zshrc"
setopt inc_append_history
setopt share_history
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/Users/afrankel02/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"  

setopt PROMPT_SUBST
# if .git-prompt.sh exists, set options and execute it
if [ -f ~/dotfiles/git-prompt.sh ]; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_HIDE_IF_PWD_IGNORED=true
  GIT_PS1_SHOWCOLORHINTS=true
  source ~/.git-prompt.sh
fi
PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '

fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/dotfiles/git-completion.bash

