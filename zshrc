source ~/.zsh/colors.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/bindkeys.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/history.zsh

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

source ~/.dotfiles/vendor/zsh-nvm/zsh-nvm.plugin.zsh
source ~/.dotfiles/vendor/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh
source ~/.dotfiles/vendor/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.dotfiles/vendor/zsh-autoenv/autoenv.zsh
source ~/.dotfiles/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh

# kiex - elixir version management
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
