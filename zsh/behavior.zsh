# TODO: incorporate completion

#
# execution

setopt rm_star_wait # wait 10 seconds before accepting 'rm *' confirmation
export REPORTTIME=5 # report timing for any command longer than 5 seconds

#
# correction

setopt correct_all

alias man='nocorrect man'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias psql='nocorrect psql'
alias mkdir='nocorrect mkdir'

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

case "$TERM" in
  xterm*|rxvt*)
    term_preexec () {
      print -Pn "\e]0;%n@%m:%~ ($1)\a"  # xterm
    }
    term_precmd () {
      print -Pn "\e]0;%n@%m:%~\a"  # xterm
    }
    ;;
  screen*)
    term_preexec () {
      local CMD=${1[(wr)^(*=*|sudo|ssh|-*)]}
      echo -ne "\ek$CMD\e\\"
      print -Pn "\e]0;%n@%m:%~($1)\a"  # xterm
    }
    term_precmd () {
      echo -ne "\ekzsh\e\\"
      print -Pn "\e]0;%n@%m:%~\a"  # xterm
    }
    ;;
esac
