# ID what OS we're running on, greet ################################################
os=`uname`
is_mac=false
has_ruby=false
completions_and_prompt_dir="$HOME/.completions"
[[ $os == "Darwin" ]] && is_mac=true
$(which ruby &>/dev/null) && has_ruby=true

echo -e "Running ~/bash_profile (is_mac=$is_mac; has_ruby=$has_ruby)"
###########################################################################
######################## CONFIG FILES #####################################
###########################################################################
# auto source any dotfile with the following names 
for file in ~/.{bashrc,path,exports,aliases,functions,extra,secrets}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

###########################################################################
######################## COMPLETIONS #####################################
###########################################################################
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    # grab brew completions if they exist
	source "$(brew --prefix)/share/bash-completion/bash_completion";
fi

[ -f /etc/bash_completion ] && source /etc/bash_completion
  # /etc/bash_completion

[ -f $completions_and_prompt_dir/git-completion.bash ] && source $completions_and_prompt_dir/git-completion.bash
  # git completions - autocomplete branches and so on

[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;
  # add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards

$is_mac && complete -W "NSGlobalDomain" defaults;
  # add tab completion for `defaults read|write NSGlobalDomain`
  
complete -o "nospace" -W "Chrome PyCharm iTerm Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;
  # Add `killall` tab completion for common apps
  #
###########################################################################
# ENV VARIABLES AND SETTINGS
###########################################################################
$is_mac && export SSH_AUTH_SOCK=$HOME/.yubiagent/sock
  # something for yubi, so only do on mac


export EDITOR=nvim
  # nvim for autoedit/sudoedit/chef edit situations

shopt -s nocaseglob;
  # case-insensitive globbing (used in pathname expansion)

shopt -s histappend;
  # append to the Bash history file, rather than overwriting it

shopt -s cdspell;
  # autocorrect typos in path names when using `cd`

shopt -s autocd 2>/dev/null
  # autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`

shopt -s globstar 2>/dev/null
# * Recursive globbing, e.g. `echo **/*.txt`


###########################################################################
# PROMPTCRAFT
###########################################################################
MAGENTA="\[\033[0;35m\]"
YELLOW="\[\033[01;33m\]"
BLUE="\[\033[00;34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"
GREEN="\[\033[00;32m\]"
RED="\[\033[0;31m\]"
VIOLET='\[\033[01;35m\]'
BOLDWHITE='\[\e[97m\e[1m\]'
REGWHITE='\[\e[0m\]'
 
if [ -f $completions_and_prompt_dir/git-prompt.sh ]; then
    # if .git-prompt.sh exists, we'll define a prompt func, wire it into bash, and source git-prompts.sh
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM="auto"
    GIT_PS1_HIDE_IF_PWD_IGNORED=true
    GIT_PS1_SHOWCOLORHINTS=true
    
    # actually call it
    source $completions_and_prompt_dir/git-prompt.sh

    function color_my_prompt {
        ###This function will get called by bash every time: ###
        
        #prompt components
        local __mac_ari_prefix="ari:"
        local __user_and_host="$BOLDWHITEari:\h:"
            # diff prefixes for diff spots

        local __cur_location="$BLUE\W" # capital 'W': current directory, small 'w': full file path

        local __git_branch_color="$GREEN"

        local __prompt_tail="$BOLDWHITE>"

        local __user_input_color="$REGWHITE"

        local __git_branch=`__git_ps1`;  # requires git-prompt.sh to be sourced

        local __venv_prompt=""
        local __venv_color="$CYAN"
        [[ -n $VIRTUAL_ENV ]] && __venv_prompt="(`basename $VIRTUAL_ENV`) "
        
        # git branch colors
        if [[ "${__git_branch}" =~ "*" ]]; then     # if repository is dirty
            __git_branch_color="$RED"
        elif [[ "${__git_branch}" =~ "$" ]]; then   # if there is something stashed
            __git_branch_color="$YELLOW"
        elif [[ "${__git_branch}" =~ "%" ]]; then   # if there are only untracked files
            __git_branch_color="$LIGHT_GRAY"
        elif [[ "${__git_branch}" =~ "+" ]]; then   # if there are staged files
            __git_branch_color="$CYAN"
        fi
         
        # actually update prompt
        $is_mac && local __prompt_prefix="$__mac_ari_prefix"
        $is_mac || local __prompt_prefix="$__user_and_host"
        PS1="$__venv_color$__venv_prompt$__prompt_prefix$__cur_location$__git_branch_color$__git_branch$__prompt_tail$__user_input_color "
    }
     
    export PROMPT_COMMAND=color_my_prompt
    # tell bash to call color_my_prompt() each time there's a prompt
     
fi

############################################################################################################## 
# PATHCRAFT
# ############################################################################################################
export PATH="$PATH:$HOME/bin"
  # personal bin
 
export PATH="/usr/local/opt/gettext/bin:$PATH"
  # needed if compiling anything from source that needs getext

$is_mac && PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
  # Python3.6 manual add since we got it from python.org

export PATH="/opt/chefdk/embedded/bin:/opt/chefdk/bin:$PATH"
  # Chef stuff

$has_ruby && export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
$has_ruby && export PATH="$PATH:$GEM_HOME/bin"
  # Ruby stuff
