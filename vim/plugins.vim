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
Plug 'sheerun/vim-polyglot'
Plug 'slashmili/alchemist.vim'
Plug 'tpope/vim-rails'

" Presentation
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" Re-enable when there's a need to regenerate a tmux theme
Plug 'edkolev/tmuxline.vim'

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
