bindkey "^K"      kill-whole-line                      # ctrl-k
bindkey "^R"      history-incremental-search-backward  # ctrl-r
bindkey "^A"      beginning-of-line                    # ctrl-a
bindkey "^E"      end-of-line                          # ctrl-e
bindkey "^D"      delete-char                          # ctrl-d
bindkey "^F"      forward-char                         # ctrl-f
bindkey "^B"      backward-char                        # ctrl-b

bindkey -e   # Default to standard emacs bindings, regardless of editor string
bindkey '[C' forward-word
bindkey '[D' backward-word

bindkey '^[[A'    history-substring-search-up          # up arrow
bindkey '^[[B'    history-substring-search-down        # down arrow
