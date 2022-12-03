completions_and_prompt_folder="$HOME/.completions"
    # trying out a folder for all this completion/prompt crap

is_mac=false
[[ $(uname) == "Darwin" ]] && is_mac=true
    # store if we're running on a mac

$is_mac && test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
    # iTerm shell integration    

echo -e "in ~/.zshrc (is_mac=$is_mac)"
####### PATH/SETTINGS #########################

export PATH="$HOME/bin:$PATH"
    # personal bin

export PATH="/usr/local/sbin:$PATH"  
    # sbin

setopt inc_append_history
    # dont overwrite history

setopt share_history
    # sessions append to same history file
    
ZSH_AUTOSUGGEST_USE_ASYNC=1
    # I dont know what this is
    
###### PROMPTCRFT ##################################
autoload colors && colors

MAGENTA="%{$fg[magenta]%}"
YELLOW="%{$fg[yellow]%}"
BLUE="%{$fg[blue]%}"
CYAN="%{$fg[cyan]%}"
GREEN="%{$fg[green]%}"
RED="%{$fg[red]%}"
WHITE="%{$fg[white]%}"
#LIGHT_GRAY='%{\[\033[0;37m\]%}'
#VIOLET='{%\[\033[01;35m\]%}'

setopt PROMPT_SUBST
if [ -f $completions_and_prompt_folder/git-prompt.sh ]; then
    # if .git-prompt.sh exists, set options and execute it:
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM="auto"
    GIT_PS1_HIDE_IF_PWD_IGNORED=true
    GIT_PS1_SHOWCOLORHINTS=true

    source $completions_and_prompt_folder/git-prompt.sh

    function color_my_prompt() {
        #This function will get called by zsh every time to generate the prompt """
        
        ###### https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html #######
        #      \- site has a full list of variables you can use in this prompt building
        local __mac_prefix="@ri "
            # prefix that will get used on MAC
 
        local __user_and_host="%n@%m"
            # prefix that will get used on _nix. %m == shortened hostname, if you want the full one flip it to %M

        local __cur_location="$BLUE%~" # capital 'W': current directory, small 'w': full file path
            # color and current folder location
            
        local __git_branch_color="$GREEN"
            # default "good" color for git branch
 
        local __prompt_tail="$WHITE> "
            # prompt tail, so the last thing of the prompt

        local __user_input_color="$WHITE"
            # color user input should be
 
        local __git_branch=$(__git_ps1)
            # this command calls the function that gets our git branch - require git-prompt.sh be sourced

        local __venv_prompt=""
        local __venv_color="$CYAN"
        [[ -n $VIRTUAL_ENV ]] && __venv_prompt="($(basename $VIRTUAL_ENV)) "
            # python virtualenv stuff
        
        ###### 
        if [[ "${__git_branch}" =~ "\*" ]]; then     # if repository is dirty
            __git_branch_color="$RED"
        elif [[ "${__git_branch}" =~ "\$" ]]; then   # if there is something stashed
            __git_branch_color="$YELLOW"
        elif [[ "${__git_branch}" =~ "%" ]]; then   # if there are only untracked files
            __git_branch_color="$LIGHT_GRAY"
        elif [[ "${__git_branch}" =~ "+" ]]; then   # if there are staged files
            __git_branch_color="$CYAN"
        fi # Color all the other git branch statuses
         
        # update prompt var
        $is_mac && local __prompt_prefix="$__mac_prefix"
        $is_mac || local __prompt_prefix="$__user_and_host"
        #PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
        PS1="$__venv_color$__venv_prompt$__prompt_prefix$__cur_location$__git_branch_color$__git_branch$__prompt_tail$__user_input_color"
    }

    # actually wire zsh up for the prompt command
   precmd() { color_my_prompt; }
     
fi



#####  COMPLETIONS
fpath=($completions_and_prompt_folder $fpath)
zstyle ':completion:*:*:git:*' script $completions_and_prompt_folger/git-completion.bash
autoload -Uz compinit && compinit


