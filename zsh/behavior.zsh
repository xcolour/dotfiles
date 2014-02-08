#
# execution

setopt rm_star_wait   # wait 10 seconds before accepting 'rm *' confirmation
export REPORTTIME=5   # report timing for any command longer than 5 seconds
unsetopt flowcontrol  # disable ^s from freezing the terminal

#
# history

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_all_dups # ignore dups including non-sequential ones
setopt share_history # share command history data between sessions
setopt hist_verify # load hist into command buffer rather than exec immediately

#
# term support

# set term title appropriately based on term type
# user@host:current_dir (current_command)
case "$TERM" in
  xterm*|rxvt*|screen*)
    term_preexec () {
      print -Pn "\e]0;%n@%m:%~ ($1)\a"  # xterm
    }
    term_precmd () {
      print -Pn "\e]0;%n@%m:%~\a"  # xterm
    }
    ;;
esac

#
# virtualenv

if [ -e /usr/local/bin/virtualenvwrapper.sh ]; then
    export VIRTUAL_ENV_DISABLE_PROMPT=true
    export WORKON_HOME=~/.virtualenv/envs
    source /usr/local/bin/virtualenvwrapper_lazy.sh
fi
