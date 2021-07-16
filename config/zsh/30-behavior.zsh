#
# execution

setopt rm_star_wait   # wait 10 seconds before accepting 'rm *' confirmation
export REPORTTIME=5   # report timing for any command longer than 5 seconds
unsetopt flowcontrol  # disable ^s from freezing the terminal

#
# history

HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/history"
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_all_dups # ignore dups including non-sequential ones
setopt share_history # share command history data between sessions
setopt hist_verify # load hist into command buffer rather than exec immediately

#
# term support

# make sure $TERM is installed
# if not, fall back on xterm-256color
infocmp "$TERM" > /dev/null 2>&1 || export TERM=xterm-256color

# set term title appropriately based on term type
# user@host:current_dir (current_command)
case "$TERM" in
  xterm*|rxvt*|screen*|alacritty*)
    term_preexec () {
        printf '\e]0;%s (%s)\a' ${(%):-'%n@%m:%~'} "$1"
    }
    term_precmd () {
        printf '\e]0;%s\a' ${(%):-'%n@%m:%~'}
    }
    ;;
esac

#
# virtualenv

if [ -e /usr/local/bin/virtualenvwrapper_lazy.sh ]; then
    vew=/usr/local/bin/virtualenvwrapper_lazy.sh
elif [ -e /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh ]; then
    vew=/usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh
fi

if [ -n "$vew" ]; then
    export VIRTUAL_ENV_DISABLE_PROMPT=true
    export WORKON_HOME=~/.virtualenv/envs
    source $vew
fi

#
# draw a horizontal separator

function hr {
    printf "$bg[red]${(l:$COLUMNS:: :)}$reset_color\n"
    printf "$bg[yellow]${(l:$COLUMNS:: :)}\n"
    printf "$bg[green]${(l:$COLUMNS:: :)}\n"
    printf "$bg[cyan]${(l:$COLUMNS:: :)}\n"
    printf "$bg[blue]${(l:$COLUMNS:: :)}\n"
    printf "$bg[magenta]${(l:$COLUMNS:: :)}$reset_color\n"
}

#
# less

export LESS=-i
