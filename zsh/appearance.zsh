#
# colorize shell programs

# ls (platform dependent)
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
export LSCOLORS="exgxbxdxcxegedxbxgxcxd"

# grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

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

# print the exit code of the previous command in red if non-zero
function return_code {
    code=$(echo $?)
    if [[ $code == "0" ]]; then
        return
    else
        echo "%{$fg[red]%}$code%{$reset_color%} "
    fi
}

# print the svn revision number (rREVISION)
function svn_prompt_info {
    info=$(svn info 2>/dev/null) || return
    rev=$(echo "$info" | grep Revision | sed 's/Revision: //')
    echo "(r${rev}) "
}

# print the current git branch (BRANCH)
function git_prompt_info {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "(${ref#refs/heads/}) "
}

# print a special prompt char in version controlled directories
function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    svn info >/dev/null 2>/dev/null && echo 'ϟ' && return
    echo '$'
}

# a colorful multiline prompt using the above defined functions
PROMPT='%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}
$(return_code)$(svn_prompt_info)$(git_prompt_info)$(prompt_char)%{$reset_color%} '
