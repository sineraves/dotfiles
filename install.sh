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
  gpg \
  python \
  reattach-to-user-namespace \
  ripgrep \
  tmux \
  tree
brew tap heroku/brew && \
  brew install heroku
brew tap universal-ctags/universal-ctags && \
  brew install --HEAD universal-ctags

echo "Adding asdf plugins"
asdf plugin-add ruby
asdf plugin-add nodejs

echo "Importing the Node.js release team's OpenPGP keys to main keyring"
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
