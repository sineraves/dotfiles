let s:current_file = expand('<sfile>')
if !exists('*packages#reload')
  func! packages#reload() abort
    exec 'source ' . s:current_file
  endfunc
endif

command! -bar PackUpdate packadd minpac | call packages#reload() | redraw | call minpac#update() | call minpac#status()
command! -bar PackClean  packadd minpac | call packages#reload() | call minpac#clean()
command! -bar PackStatus packadd minpac | call packages#reload() | call minpac#status()

if !exists('*minpac#init')
  finish
endif

call minpac#init({'verbose': 0})

call minpac#add('jiangmiao/auto-pairs')

" Languages
call minpac#add('elixir-lang/vim-elixir')
call minpac#add('sheerun/vim-polyglot')

" Text manipulation
call minpac#add('AndrewRadev/splitjoin.vim')
call minpac#add('andymass/vim-matchup')
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('junegunn/vim-easy-align')
call minpac#add('junegunn/vim-peekaboo')
call minpac#add('machakann/vim-sandwich')
call minpac#add('tpope/vim-abolish')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-repeat')

" LSP
call minpac#add('prabirshrestha/async.vim')
call minpac#add('prabirshrestha/vim-lsp')

" Linting & fixing
call minpac#add('dense-analysis/ale')
call minpac#add('mhinz/vim-mix-format')

" Completion
call minpac#add('roxma/nvim-yarp')
call minpac#add('ncm2/ncm2')
call minpac#add('ncm2/float-preview.nvim')
call minpac#add('ncm2/ncm2-bufword')
call minpac#add('ncm2/ncm2-path')
call minpac#add('ncm2/ncm2-vim-lsp')
call minpac#add('ncm2/ncm2-html-subscope')
call minpac#add('ncm2/ncm2-markdown-subscope')

" Snippets
call minpac#add('SirVer/ultisnips')
call minpac#add('honza/vim-snippets', {'type': 'opt'})
call minpac#add('ncm2/ncm2-ultisnips')

" Fuzzy finder
call minpac#add('justinmk/vim-dirvish')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')

call minpac#add('tpope/vim-projectionist')

" Colours
call minpac#add('dracula/vim', {'name': 'dracula'})

call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('edkolev/tmuxline.vim')
