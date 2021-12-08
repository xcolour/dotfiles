# initialize the completion system
autoload -U compinit
compinit -d "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompdump"
zmodload zsh/complist

# complete only after the second consecutive tab
setopt auto_menu

# use GNU ls color specification for completion menu
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# use menu selection by default
zstyle ':completion:*:default' menu select

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# don't autocomplete local users for (ssh|ftp|scp|rsync)
zstyle ':completion:*:*:(ssh|ftp|scp|rsync):*' users

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompcache"

# always rehash commands list
zstyle ':completion:*:commands' rehash 1
