# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="xcolour"

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

export LSCOLORS="exgxbxdxcxegedxbxgxcxd"

export EDITOR=vim

bindkey "\e[3~" delete-char

if [ -e $HOME/.zshrc-local ]; then
    source $HOME/.zshrc-local
fi

# runs after local because 'most' isn't standard,
# and macports will be set up in local
if [[ -e $(which most) ]]; then
    export PAGER=most
fi

# run after local because local because user bin should
# take absolute priority
export PATH=$HOME/bin:$PATH
