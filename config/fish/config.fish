fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin
fish_add_path -a bin

set -gx TERM screen-256color
set -gx EDITOR nvim           # neovim
set -gx VISUAL nvim           # ... for everything
set -gx GPG_TTY (tty)         # required for signing git commits with gpg key

if type -q bat
  set -gx PAGER bat
end

# Decide bat theme from iterm profile name
# https://github.com/sharkdp/bat
if test "$ITERM_PROFILE" = "dark"
  set -gx BAT_THEME "Dracula"
else if test "$ITERM_PROFILE" = "light"
  set -gx BAT_THEME "Monokai Extended Light"
end

abbr -U be bundle exec
abbr -U dc docker compose
abbr -U g git
abbr -U gd git diff
abbr -U gdc git diff --cached
abbr -U gl git log --decorate --oneline
abbr -U gs git status --short
abbr -U myip dig +short myip.opendns.com @resolver1.opendns.com
abbr -U mux tmuxinator

# https://the.exa.website
# Modern replacement for `ls`
if type -q exa
  abbr -U ll exa -l -g --icons
  abbr -U lla exa -l -g --icons -a
end

# ASDF version manager, installed with Homebrew
source /opt/homebrew/opt/asdf/libexec/asdf.fish
