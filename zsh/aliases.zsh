alias ls='ls -GFh'
alias ll='ls -GFhl'
alias la='ls -GFhla'

alias mux=tmuxinator

alias startpost='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias stoppost='pg_ctl -D /usr/local/var/postgres stop'

alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log --decorate --oneline'
alias gs='git status --short'

alias be='bundle exec'
alias biv='bundle install --path vendor/bundle'
alias rake='noglob rake'

alias ff='find * -type f | fzf'
alias fv='vim $(fzf)'
