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
brew install bat exa fd fzf git neovim node python rbenv reattach-to-user-namespace ripgrep tmux tree z
brew tap heroku/brew && brew install heroku
brew tap universal-ctags/universal-ctags && brew install --HEAD universal-ctags

latest_mri_ruby=$(rbenv install -l | grep -v - | tail -1 | tr -d '[:space:]')
echo "Installing ruby ${latest_mri_ruby}"
rbenv install $latest_mri_ruby
rbenv global $latest_mri_ruby
gem install bundler rubocop tmuxinator
rbenv rehash

echo "Installing zgen"
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
