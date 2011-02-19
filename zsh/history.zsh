#done

## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_all_dups # ignore dups including non-sequential ones
setopt share_history # share command history data between sessions
setopt hist_verify # load hist into command buffer rather than exec immediately
