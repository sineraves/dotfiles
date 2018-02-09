alias ls='ls -GFh'
alias ll='ls -GFhl'
alias la='ls -GFhla'

alias mux=tmuxinator

alias startpost='pg_ctl -D pg_ctl -D /usr/local/var/postgresql@9.6 -l /usr/local/var/postgresql@9.6/server.log start'
alias stoppost='pg_ctl -D /usr/local/var/postgresql@9.6 stop'

alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log --decorate --oneline'
alias gs='git status --short'

alias be='bundle exec'
alias biv='bundle install --path vendor/bundle'
alias rake='noglob rake'

alias ff='find * -type f | fzf'
alias fv='vim $(fzf)'
