fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/openssl@3/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

# Keep an eye on the effects of this!
set -gx XDG_CONFIG_HOME "$HOME/.config"

set -gx TERM screen-256color
set -gx EDITOR nvim           # neovim
set -gx VISUAL nvim           # ... for everything
set -gx GPG_TTY (tty)         # required for signing git commits with gpg key

set -gx LDFLAGS "-L/opt/homebrew/opt/openssl@3/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/openssl@3/include"

set -gx PNPM_HOME "/Users/matt/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# https://github.com/sharkdp/bat
if type -q bat
  set -gx PAGER bat
  set -gx BAT_STYLE 'numbers,changes'
  set -gx BAT_THEME 'tokyonight'
end

abbr -U be bundle exec

abbr -U dc docker compose
abbr -U dce docker compose exec
abbr -U dcr docker compose run

abbr -U g git
abbr -U gd git diff
abbr -U gdc git diff --cached
abbr -U gl "git log --pretty='%C(yellow)%h %C(cyan)%cd %Cblue%aN%C(auto)%d %s' --date=short --date-order"
abbr -U gs git status --short
abbr -U myip dig +short myip.opendns.com @resolver1.opendns.com
abbr -U mux tmuxinator

# https://the.exa.website
# Modern replacement for `ls`
if type -q exa
  abbr -U ll exa -l -g --icons
  abbr -U lla exa -l -g --icons -a
  abbr -U tree exa -l -g --icons --tree
end

# direnv
if type -q direnv
  direnv hook fish | source
end

# ASDF version manager, installed with Homebrew
if type -q asdf
  source /opt/homebrew/opt/asdf/libexec/asdf.fish
end
