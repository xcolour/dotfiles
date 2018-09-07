export EDITOR=vim
export LANG=en_US.UTF-8

if [ -e "$HOME/.zshrc-local" ]; then
    source "$HOME/.zshrc-local"
fi

source "$HOME/.zsh/appearance.zsh"
source "$HOME/.zsh/behavior.zsh"
source "$HOME/.zsh/completion.zsh"
source "$HOME/.zsh/key-bindings.zsh"

# override builtin functions (preexec, precmd, etc.)
source "$HOME/.zsh/functions.zsh-overrides"

# user bin should take absolute priority
export PATH="$HOME/bin:$PATH"
