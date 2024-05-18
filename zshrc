# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Zinit & plugins location
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit when not present
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "$ZINIT_HOME/zinit.zsh"

# Prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Plugins

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippets

zinit snippet OMZP::asdf
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Key bindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^u' backward-kill-line

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space # prepend command with space to prevent saving to histfile
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -l -g --icons=auto --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -l -g --icons=auto --color=always $realpath'

# User specific ########################################################################################################

export GOPATH=$(go env GOPATH)
export GOROOT=$(go env GOROOT)
export GOBIN=$(go env GOBIN)

path+=("$HOME/.bun/bin" "$GOPATH/bin" "$HOME/.local/bin" "/opt/homebrew/opt/llvm/bin")
export path

export GPG_TTY=$(tty)
export XDG_CONFIG_HOME="$HOME/.config"
export BAT_STYLE='numbers,changes'
export BAT_THEME='tokyonight_moon'

export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"

# Enable history in erlang/elixir shell
export ERL_AFLAGS="-kernel shell_history enabled"
# Build erlang/OTP with EEP48 documentation chunks
export KERL_BUILD_DOCS=yes

if [[ -x $(which nvim) ]]
  export EDITOR=nvim
  export VISUAL=nvim
then
fi

# Aliases
alias ls='ls --color'

alias be='bundle exec'
alias bi='bundle install'
alias br='bundle exec rspec'

alias brc='brew cleanup'
alias bro='brew outdated'
alias bru='brew upgrade'

alias ll='eza -l -g --icons=auto'
alias lla='eza -l -g --icons=auto -a'
alias tree='eza -l -g --icons=auto --tree'

alias g='git'
alias ga='git add'
alias gb='git branch'
alias gco='git checkout'
alias gcm='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl="git log --pretty='%C(yellow)%h %C(cyan)%cd %Cblue%aN%C(auto)%d %s' --date=short --date-order"
alias gr='git rebase'
alias gra='git rebase -i --autosquash'
alias gs='git status --short'

alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

function godoc() {
  go doc $@ | bat --file-name doc.go
}

function safecd {
  if [ ! -z "$1" ]; then
    cd $1
  fi
}

function s() {
  local args=''

  if [ ! -z "$1" ]; then
    args="-q $1"
  fi

  safecd $(projector -c $HOME/_/projects -e '.*_archived.*' list | fzf $args)
}

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Opam for OCAML
[[ ! -r /Users/matt/.opam/opam-init/init.zsh ]] || source /Users/matt/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Indeed k8s
[ -f "/Users/matt/.indeed-kube-profile" ] && source "/Users/matt/.indeed-kube-profile"

# bun completions
[ -s "/Users/matt/.bun/_bun" ] && source "/Users/matt/.bun/_bun"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
