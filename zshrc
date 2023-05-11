# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
# zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install


# ------------------------------
# Sineraves
# ------------------------------

export GOPATH=$(go env GOPATH)
export GOROOT=$(go env GOROOT)
export GOBIN=$(go env GOBIN)

path+=("$GOPATH/bin" "$HOME/.local/bin" "/opt/homebrew/opt/llvm/bin")
export PATH

export GPG_TTY=$(tty)
export XDG_CONFIG_HOME="$HOME/.config"
export BAT_STYLE='numbers,changes'

export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"

if [[ -x $(which nvim) ]]
  export EDITOR=nvim
  export VISUAL=nvim
then
fi

if [[ -x $(which bat) ]]
then
  export PAGER=bat
fi

alias n='nvim'
alias mux='tmuxinator'

alias r='ranger'

alias be='bundle exec'
alias br='bundle exec rspec'

alias bo='brew update && brew outdated'
alias bu='brew upgrade'

alias dc='docker compose'
alias dce='docker compose exec'
alias dcr='docker compose run'
alias dcs='docker compose restart'

alias ll='exa -l -g --icons'
alias lla='exa -l -g --icons -a'
# alias tree='exa -l -g --icons --tree'

alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl="git log --pretty='%C(yellow)%h %C(cyan)%cd %Cblue%aN%C(auto)%d %s' --date=short --date-order"
alias gs='git status --short'

alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

function config-open() {
  nvim ~/.zshrc
}

function config-reload() {
  source ~/.zshrc
  echo "Reloaded ~/.zshrc"
}

function godoc() {
  go doc $@ | bat --file-name doc.go
}

# Colours

# TODO: move functions to files and load in fpath?
function set_theme() {
  theme=$(<~/.term_theme)

  if [[ "$theme" = "light" ]]
  then
    local kitty_theme='Catppuccin-Latte'
    local bat_theme='Catppuccin-latte'
  else
    local kitty_theme='Catppuccin-Macchiato'
    local bat_theme='Catppuccin-macchiato'
  fi

  export BAT_THEME=$bat_theme
  if [[ -x $(which kitty) ]]
  then
    kitty +kitten themes --reload-in=all $kitty_theme
  fi
}

function toggle_theme() {
  theme=$(<~/.term_theme)

  if [[ "$theme" = "light" ]]
  then
    echo 'dark' >| ~/.term_theme
  else
    echo 'light' >| ~/.term_theme
  fi

  set_theme
}

set_theme

# Starship prompt
if [[ -x $(which starship) ]]
then
  eval "$(starship init zsh)"
fi
