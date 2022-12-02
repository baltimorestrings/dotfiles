echo "Users/baltiomrestrings/.zshrc"
is_mac=false
[ $(uname) == "Darwin" ] && is_mac=true
$is_mac && test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
    # iTerm is cool
    
####### PATH/SETTINGS

export PATH="$HOME/bin:$PATH"
    # personal bin

export PATH="/usr/local/sbin:$PATH"  
    # sbin

setopt inc_append_history
    # dont overwrite history

setopt share_history
    # sessions append to same history file
    #
ZSH_AUTOSUGGEST_USE_ASYNC=1
    # I dont know what this is
    #
###### PROMPTCRFT
#
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

#####  COMPLETIONS
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/dotfiles/git-completion.bash
autoload -Uz compinit && compinit


