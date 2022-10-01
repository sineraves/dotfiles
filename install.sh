#!/usr/bin/env sh

echo "Installing homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing homebrew packages"
brew install asdf     # Extensible version manager
brew install bat      # `cat` clone with syntax highlighting, git
brew install bottom   # Process/system monitor (`btm`)
brew install exa      # Better `ls`
brew install fd       # User-friendly `find`
brew install gh       # GitHub niceties
brew install neovim   # Text editor
brew install ripgrep  # Search
brew install sd       # Friendlier `sed`
brew install stylua   # Lint and format lua neovim config

echo "Adding asdf plugins"
asdf plugin-add nodejs
asdf plugin-add postgres
asdf plugin-add python
asdf plugin-add ruby
