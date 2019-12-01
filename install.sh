#!/usr/bin/env sh

echo "Installing homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing homebrew packages"
brew install asdf bat coreutils exa fd fzf gpg neovim postgresql@11 reattach-to-user-namespace ripgrep tmux tree z
brew tap heroku/brew && brew install heroku
brew tap universal-ctags/universal-ctags && brew install --HEAD universal-ctags

echo "Adding asdf plugins"
asdf plugin-add erlang
asdf plugin-add elixir
asdf plugin-add nodejs
asdf plugin-add ruby

echo "Installing zgen"
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
