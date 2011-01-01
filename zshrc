# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="sporty_256"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# MacPorts Installer addition on 2010-04-13_at_22:39:42: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH=/usr/local/texlive/2009basic/bin/universal-darwin:$PATH
export PATH=$HOME/bin:$PATH

export LSCOLORS="exgxbxdxcxegedxbxgxcxd"

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    svn info >/dev/null 2>/dev/null && echo 'ϟ' && return
    echo '$'
}

function svn_dirty {
    if [[ -n $(svn status) ]]; then
        echo "%{$fg[red]%}✘%{$reset_color%}"
    else
        echo "%{$fg[green]%}✔%{$reset_color%}"
    fi
}

function svn_prompt_info {
    info=$(svn info 2>/dev/null) || return
    rev=$(echo "$info" | grep Revision | sed 's/Revision: //')
    echo "(r$rev$(svn_dirty)) "
}

PROMPT='%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}
$(git_prompt_info)$(svn_prompt_info)$(prompt_char) %{$reset_color%}'
RPROMPT='%D{%r}'

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✘%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔%{$reset_color%}"

export PAGER=most
export EDITOR=vim
