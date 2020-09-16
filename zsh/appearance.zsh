#
# colorize shell programs

if ls --color -d . &>/dev/null 2>&1; then
    alias ls='ls --color=tty'
    eval `dircolors ~/.dircolors.conf`
else
    alias ls='ls -G'
    export LSCOLORS="exgxbxdxcxegedxbxgxcxd"
fi

# grep
export GREP_COLOR='1;32'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# less
export LESS_TERMCAP_mb=$'\e[0;31m'     # begin blinking      - red
export LESS_TERMCAP_md=$'\e[0;34m'     # begin bold          - blue
export LESS_TERMCAP_me=$'\e[0m'        # end mode
export LESS_TERMCAP_so=$'\e[30;46m'    # begin standout mode - black on cyan
export LESS_TERMCAP_se=$'\e[0m'        # end standout mode
export LESS_TERMCAP_us=$'\e[4;33m'     # begin underline     - yellow underline
export LESS_TERMCAP_ue=$'\e[0m'        # end underline

#
# make a sweet prompt

autoload colors; colors;
setopt prompt_subst # expansion of color codes, etc. in the prompt

# print the fully resolved shell command with time stamp
# to be run from zsh's builtin 'preexec' with all arguments passed through ($*)
function theme_preexec () {
    echo "($fg[magenta]`date +%r`$reset_color) $fg[cyan]$3$reset_color"
}

# print the prompt char in red if the last command exited non-zero
function prompt_char {
    echo "%(?.$.%{$fg[red]%}$%{$reset_color%})"
}

function repo_prompt_info {
    # git
    ref=$(git symbolic-ref HEAD 2> /dev/null || git rev-parse --short HEAD 2> /dev/null)
    if [ $? -eq 0 ]; then
        #repo=$(basename $(git rev-parse --show-toplevel))
        echo "%{$fg[cyan]%}%{\e[1m%}${ref#refs/heads/}%{$reset_color%}"
        return
    fi
}

function workspace_prompt_info {
    repo=$(repo_prompt_info)
    if [ "$repo" ]; then
        echo "[$repo] "
        return
    fi
}

# print the hostname in green if local, else red
function hostname_info {
    if [[ $ZSH_LOCAL_ENV == "true" ]]; then
        echo "%{$fg[green]%}%{$ZSH_HOST_PREFIX%}%m%{$ZSH_HOST_SUFFIX%}%{$reset_color%}"
    else
        echo "%{$fg[red]%}%{$ZSH_HOST_PREFIX%}%m%{$ZSH_HOST_SUFFIX%}%{$reset_color%}"
    fi
}

# a colorful multiline prompt using the above defined functions
PROMPT=$'%{$fg[yellow]%}%n%{$reset_color%}@$(hostname_info):%{$fg[blue]%}%~%{$reset_color%}
$(workspace_prompt_info)$(prompt_char)%{$reset_color%} '
