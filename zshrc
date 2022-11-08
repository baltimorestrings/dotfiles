ZSH_AUTOSUGGEST_USE_ASYNC=1
echo "Users/baltiomrestrings/.zshrc"
setopt auto_cd
alias vim=nvim
alias vimon='bindkey -v'
alias vimoff='bindkey -e'
setopt inc_append_history
setopt share_history
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
