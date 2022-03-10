source ~/.zsh/aliases.zsh
source ~/.zsh/options.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/keys.zsh
source ~/.zsh/prompt.zsh

source ~/.zsh/plugins/zsh-autoenv/autoenv.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

################################################################################

# https://github.com/rupa/z
[ -f /usr/local/etc/profile.d/z.sh ] && source /usr/local/etc/profile.d/z.sh

# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://github.com/SidOfc/cani
[ -f ~/.config/cani/completions/_cani.zsh ] && source ~/.config/cani/completions/_cani.zsh

# https://github.com/asdf-vm/asdf
[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ] && source /opt/homebrew/opt/asdf/libexec/asdf.sh

# https://cloud.google.com/sdk - PATH
[ -f ~/_/tools/google-cloud-sdk/path.zsh.inc ] && source ~/_/tools/google-cloud-sdk/path.zsh.inc

# https://cloud.google.com/sdk - completion
[ -f ~/_/tools/google-cloud-sdk/completion.zsh.inc ] && source ~/_/tools/google-cloud-sdk/completion.zsh.inc
