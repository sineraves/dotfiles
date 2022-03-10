#!/usr/bin/env sh

echo "Installing homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing homebrew packages"
brew install \
  asdf \
  bat \
  exa \
  fd \
  fzf \
  ripgrep \
  tmux \
  tree
brew tap heroku/brew && brew install heroku

echo "Adding asdf plugins"
asdf plugin-add ruby
asdf plugin-add python
asdf plugin-add nodejs
