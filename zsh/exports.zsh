# Use brew installed python 3 instead of system 2.7
path=(/usr/local/opt/python@3.9/libexec/bin /usr/local/sbin $path)
export PATH

export CLICOLOR=1
export LC_COLLATE=C
export TERM=screen-256color
export VISUAL=nvim

export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git' -g '!.keep'"

# decide `bat` theme from iTerm profile
if [ "$ITERM_PROFILE" = 'dark' ]; then
  export BAT_THEME='Monokai Extended'
elif [ "$ITERM_PROFILE" = 'light' ]; then
  export BAT_THEME='Monokai Extended Light'
fi
