export CLICOLOR=1
export LC_COLLATE=C
export TERM=screen-256color
export VISUAL=vim

export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git' -g '!.keep'"

export ERL_AFLAGS='-kernel shell_history enabled'
export KERL_CONFIGURE_OPTIONS='--disable-debug --without-javac'

# decide `bat` theme from iTerm profile
if [ "$ITERM_PROFILE" = 'dark' ]; then
  export BAT_THEME='Monokai Extended'
elif [ "$ITERM_PROFILE" = 'light' ]; then
  export BAT_THEME='Monokai Extended Light'
fi
