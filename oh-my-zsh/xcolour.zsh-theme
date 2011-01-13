# Matt Singleton's oh-my-zsh theme

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    svn info >/dev/null 2>/dev/null && echo 'ϟ' && return
    echo '$'
}

function return_code {
    code=$(echo $?)
    if [[ $code == "0" ]]; then
        return
    else
        echo "%{$fg[red]%}$code%{$reset_color%} "
    fi
}

function parse_git_branch {
    echo "${ref#refs/heads/}"
}

function parse_git_staged {
    $(git diff-index --quiet --cached HEAD) && return
    echo "staged"
}
function parse_git_unstaged {
    $(git diff-files --quiet) && return
    echo "unstaged"
}

function my_git_prompt_info {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#     # staged
#    git diff-index --quiet --cached HEAD
#    if [ $? -eq 1 ]; then
#        echo "(%{$fg[yellow]%}${ref#refs/heads/}%{$reset_color%}) "
#        return
#    fi
#     # uunstaged
#    git ls-files --exclude-standard --others
#    if [ $? -eq 1 ]; then
#        echo "(%{$fg[red]%}${ref#refs/heads/}%{$reset_color%}) "
#        return
#    fi
#     # untracked and unignored
#    git diff-files --quiet
#    if [ $? -eq 1 ]; then
#        echo "(%{$fg[red]%}${ref#refs/heads/}%{$reset_color%}) "
#        return
#    fi
    echo "(${ref#refs/heads/}) "
}

PROMPT='%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}
$(return_code)$(my_git_prompt_info)$(prompt_char) %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✘%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔%{$reset_color%}"

ZSH_THEME_SVN_PROMPT_PREFIX="("
ZSH_THEME_SVN_PROMPT_SUFFIX=") "
ZSH_THEME_SVN_PROMPT_DIRTY="%{$fg[red]%}✘%{$reset_color%}"
ZSH_THEME_SVN_PROMPT_CLEAN="%{$fg[green]%}✔%{$reset_color%}"
