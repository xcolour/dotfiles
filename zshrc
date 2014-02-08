for config_file (~/.zsh/*.zsh); do
    source $config_file
done

export EDITOR=vim
export LANG=en_US.UTF-8

if [ -e $HOME/.zshrc-local ]; then
    source $HOME/.zshrc-local
fi

# run after local because local because user bin should
# take absolute priority
export PATH=$HOME/bin:$PATH

# override builtin functions (preexec, precmd, etc.)
source ~/.zsh/functions.zsh-overrides
