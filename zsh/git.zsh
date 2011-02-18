#done

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

function git_prompt_info {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "(${ref#refs/heads/}) "
}
