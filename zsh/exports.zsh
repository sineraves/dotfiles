export CLICOLOR=1
export EDITOR=nvim
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git' -g '!.keep'"
export LC_COLLATE=C
export TERM=screen-256color
export VISUAL=nvim

# decide `bat` theme from iTerm profile
if [ "$ITERM_PROFILE" = 'dark' ]; then
  export BAT_THEME='Monokai Extended'
elif [ "$ITERM_PROFILE" = 'light' ]; then
  export BAT_THEME='Monokai Extended Light'
fi
