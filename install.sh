#!/usr/bin/env sh

echo "Installing homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing zsh"
brew install zsh
echo /usr/local/bin/zsh | sudo tee -a /etc/shells
echo "Switching to zsh"
chsh -s /usr/local/bin/zsh
env zsh

echo "Installing homebrew packages"
brew install direnv elixir fzf git heroku-toolbelt most openssl postgresql python rbenv reattach-to-user-namespace ripgrep ruby-build tmux tree vim zsh-history-substring-search
brew tap universal-ctags/universal-ctags && brew install --HEAD universal-ctags

latest_mri_ruby=$(rbenv install -l | grep -v - | tail -1 | tr -d '[:space:]')
echo "Installing ruby ${latest_mri_ruby}"
rbenv install $latest_mri_ruby
rbenv global $latest_mri_ruby
gem install bundler reek rubocop scss_lint tmuxinator
rbenv rehash
