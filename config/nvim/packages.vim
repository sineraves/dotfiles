function! PackInit() abort
  packadd minpac

  call minpac#init({
        \     'progress_open': 'vertical',
        \     'status_open': 'vertical',
        \     'status_auto': 1
        \   })
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Languages
  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('lepture/vim-jinja')

  call minpac#add('neovim/nvim-lspconfig')
  call minpac#add('nvim-lua/completion-nvim')
  call minpac#add('nvim-lua/lsp_extensions.nvim')

  " Text manipulation
  call minpac#add('AndrewRadev/splitjoin.vim')
  call minpac#add('andymass/vim-matchup')
  call minpac#add('editorconfig/editorconfig-vim')
  call minpac#add('junegunn/vim-easy-align')
  call minpac#add('junegunn/vim-peekaboo')
  call minpac#add('machakann/vim-sandwich')
  call minpac#add('mattn/emmet-vim')
  call minpac#add('tpope/vim-abolish')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-repeat')

  " Linting, fixing, and testing
  call minpac#add('vim-test/vim-test')

  " File navigation
  call minpac#add('justinmk/vim-dirvish')

  call minpac#add('tpope/vim-dispatch')
  call minpac#add('radenling/vim-dispatch-neovim')
  call minpac#add('tpope/vim-projectionist')

  " Colours & UI
  call minpac#add('dracula/vim', {'name': 'dracula'})
  call minpac#add('chriskempson/base16-vim')
  call minpac#add('lifepillar/vim-solarized8')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')
  call minpac#add('edkolev/tmuxline.vim')
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
