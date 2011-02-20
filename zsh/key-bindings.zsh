#done

bindkey -e # use emacs mode
bindkey '^r' history-incremental-search-backward # ctrl-r
bindkey '^[[Z' reverse-menu-complete # shift-tab

bindkey '\e[3~' delete-char # make sure delete key works
bindkey ' ' magic-space # also do history expansion on space
