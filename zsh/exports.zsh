export FPATH=$HOME/.dotfiles/vendor/zsh-completions/src:$FPATH
export PATH=$HOME/Library/Haskell/bin:/usr/local/opt/python/libexec/bin:/usr/local/sbin:/usr/local/bin:~/.local/bin:$PATH
export PATH=/usr/local/opt/qt@5.5/bin:$PATH

# Setup terminal, and turn on colors
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# This resolves issues install the mysql, postgres,
# and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'
export EDITOR='vim'
# CTAGS Sorting in VIM/Emacs is better behaved with this in place
export LC_COLLATE=C

# Configure FZF to use rimgrep
# Using globs while setting `--no-ignore` so I can still find some
# git ignored files I consider interesting.
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.elixir_ls/" --glob "!.git/" --glob "!_build/" --glob "!deps/" --glob "!node_modules/" --glob "!vendor/bundle/"'

# Get history in elixir shells
export ERL_AFLAGS='-kernel shell_history enabled'
