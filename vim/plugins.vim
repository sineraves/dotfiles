let s:plugged_dir = $HOME . '/.vim/plugged'
call plug#begin(s:plugged_dir)

" Language / Syntax
Plug 'sheerun/vim-polyglot'
Plug 'slashmili/alchemist.vim'
Plug 'tpope/vim-rails'
Plug 'tweekmonster/django-plus.vim'

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
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/echodoc.vim'
Plug 'zchee/deoplete-jedi'

" Interface
Plug 'lifepillar/vim-solarized8'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" Re-enable when there's a need to regenerate a tmux theme
" Plug 'edkolev/tmuxline.vim'

" System
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'pbrisbin/vim-mkdir'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'

" Testing, Linting, and Fixing
Plug 'janko-m/vim-test'
Plug 'w0rp/ale'
Plug 'mhinz/vim-mix-format'

call plug#end()
