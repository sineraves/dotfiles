let s:plugged_dir = $HOME . '/.vim/plugged'
call plug#begin(s:plugged_dir)

" Language / Syntax
Plug 'sheerun/vim-polyglot'
Plug 'slashmili/alchemist.vim'

" Editing
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ap/vim-css-color'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'kana/vim-textobj-user' | Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Completion and Reference
if has('nvim')
  Plug 'roxma/nvim-yarp' | Plug 'ncm2/ncm2'
  Plug 'ncm2/ncm2-bufword'
  Plug 'ncm2/ncm2-cssomni'
  Plug 'ncm2/ncm2-jedi'
  Plug 'ncm2/ncm2-neosnippet'
  Plug 'ncm2/ncm2-path'
  Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}
  Plug 'ncm2/ncm2-vim-lsp'
  Plug 'pbogut/ncm2-alchemist'
endif
Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/echodoc.vim'

" Interface
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" Re-enable when there's a need to regenerate a tmux theme
" Plug 'edkolev/tmuxline.vim'

" System
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'pbrisbin/vim-mkdir'
Plug 'tpope/vim-eunuch'

" Testing, Linting, and Fixing
Plug 'dense-analysis/ale'
Plug 'mhinz/vim-mix-format'

call plug#end()
