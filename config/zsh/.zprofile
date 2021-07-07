if [ "$(uname)" = "Darwin" ]; then
    # disable Apple Terminal's annoying session restore feature
    SHELL_SESSIONS_DISABLE=1
fi
