fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin
fish_add_path -a bin

set -gx TERM screen-256color
set -gx EDITOR nvim           # neovim
set -gx VISUAL nvim           # ... for everything
set -gx GPG_TTY (tty)         # required for signing git commits with gpg key

# Decide bat theme from iterm profile name
# https://github.com/sharkdp/bat
if test "$ITERM_PROFILE" = "dark"
  set -gx BAT_THEME "Dracula"
else if test "$ITERM_PROFILE" = "light"
  set -gx BAT_THEME "Monokai Extended Light"
end

alias be "bundle exec"
alias dc "docker compose"
alias g git
alias gd "git diff"
alias gdc "git diff --cached"
alias gl "git log --decorate --oneline"
alias gs "git status --short"
alias myip "dig +short myip.opendns.com @resolver1.opendns.com"
alias mux tmuxinator

# https://the.exa.website
# Modern replacement for `ls`
if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

# ASDF version manager, installed with Homebrew
source /opt/homebrew/opt/asdf/libexec/asdf.fish
