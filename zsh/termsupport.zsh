#done

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
