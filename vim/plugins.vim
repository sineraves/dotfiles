function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

let s:plugged_dir = $HOME . '/.vim/plugged'
call plug#begin(s:plugged_dir)

" Completion
Plug 'sirver/ultisnips'
Plug 'Shougo/neocomplete.vim'

" Editing
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ap/vim-css-color'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-textobj-user' | Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Files
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'pbrisbin/vim-mkdir'

" Language / Syntax
Plug 'ElmCast/elm-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/es.next.syntax.vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'slashmili/alchemist.vim'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

" Presentation
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" Re-enable when there's a need to regenerate a tmux theme
" Plug 'edkolev/tmuxline.vim'

" System
Plug 'ludovicchabant/vim-gutentags'
Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'

" Testing / Linting
Plug 'janko-m/vim-test'
Plug 'w0rp/ale'

" Workspace
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-projectionist'

call plug#end()
