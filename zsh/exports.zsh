path=(
  /usr/local/opt/postgresql@12/bin
  /usr/local/sbin
  ~/.local/bin
  $path
)
export PATH

export CLICOLOR=1
export EDITOR=nvim
export LC_COLLATE=C
export TERM=screen-256color
export VISUAL=nvim

export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git' -g '!.keep'"
export LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib"

# decide `bat` theme from iTerm profile
if [ "$ITERM_PROFILE" = 'dark' ]; then
  export BAT_THEME='Monokai Extended'
elif [ "$ITERM_PROFILE" = 'light' ]; then
  export BAT_THEME='Monokai Extended Light'
fi
