" General ======================================================================

" a mighty good leader
let mapleader = ","

if !has('nvim') " load sensible neovim defaults on regular vim
  set encoding=utf-8
  silent! runtime sensible.vim
endif

runtime packages.vim
let g:loaded_netrwPlugin = 1

set hidden                        " allow switching between unsaved buffers
set splitbelow splitright         " sensible splits
set nobackup noswapfile           " disable backups and swaps
set undofile


" Interface ====================================================================

" true colour
if has('termguicolors')
  set termguicolors
endif

" infer background from named iterm profile
if $ITERM_PROFILE == 'light'
  set background=light
  colorscheme base16-tomorrow
elseif $ITERM_PROFILE == 'dark'
  set background=dark
  packadd! dracula
  colorscheme dracula
endif

set title                         " set window title
set synmaxcol=400                 " don't try and highlight crazy long lines
set textwidth=80                  " default text wrap, when enabled
set colorcolumn=+1                " highlight column after textwidth
set cursorline                    " highlight line of cursor
set noshowmode                    " don't put mode message on last line
set nowrap                        " by default, don't wrap lines
set number                        " show absolute number for current line
set relativenumber                " use relative numbers for other lines
set numberwidth=5                 " nice padding for line numbers
set switchbuf=useopen             " re-use open windows for buffers
set wildmode=list:longest,full

" ignore generated files
set wildignore=*.o,*~,*/.git,*/tmp/*,*/node_modules/*,*/_build/*,*/deps/*,*/target/*

" visual cues
set fillchars=diff:⣿,vert:│,fold:·
set list listchars=tab:»·,trail:·,nbsp:·


" Editing ======================================================================

set preserveindent                    " try to preserve structure when indenting
set shiftwidth=2                      " use 2 spaces for indentation steps
set shiftround                        " round shift to multiples of `shiftwidth`
set expandtab                         " expands tabs to spaces
set softtabstop=-1                    " tab inserts `sw` spaces in edit mode
set nojoinspaces                      " only insert one space after joins

let g:html_indent_tags = ['p', 'li']  " indent p and li tags
" fix end tag highlighting in html etc
highlight link xmlEndTag xmlTag

augroup editing
  au!

  " set filetypes for given files/extensions
  au BufNewFile,BufRead *.df set ft=dockerfile
  au BufNewFile,BufRead *.md set filetype=markdown
  au BufNewFile,BufRead .{babel,jshint,eslint,stylelint}rc set filetype=json

  " return to same line when re-opening files
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Completion & snippets ========================================================

set completeopt=noinsert,menuone,noselect
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

autocmd BufEnter * call ncm2#enable_for_buffer()

" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0


" Search =======================================================================

set ignorecase smartcase          " ignore case when search query lowercase
set wrapscan                      " searches wrap around file
if executable('rg')               " use rg for `grep` command (but prefer `:Rg`)
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif


" Plugin Configuration =========================================================

" ale: general config
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fix_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'always'

" ale: language-specific config
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_python_auto_pipenv = 1

" ale: linters
let g:ale_linters = {}
let g:ale_linters.css = ['stylelint']
let g:ale_linters.elixir = ['credo', 'elixir-ls']
let g:ale_linters.python = ['flake8']
let g:ale_linters.ruby = ['rubocop']
let g:ale_linters.scss = ['stylelint']

" ale: fixers (overwrites files on save)
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_fixers.css = ['stylelint']
let g:ale_fixers.elixir = ['mix_format']
let g:ale_fixers.javascript = ['prettier']
let g:ale_fixers.python = ['black']
let g:ale_fixers.scss = ['stylelint']

" vim-airline
if $ITERM_PROFILE == 'light'
  let g:airline_theme = 'tomorrow'
else
  let g:airline_theme = 'zenburn'
endif
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" vim-gutentags
let g:gutentags_ctags_exclude = [
      \ 'node_modules',
      \ 'vendor',
      \ '.elixir_ls',
      \ 'dist',
      \ '_build'
      \]

" vim-peekaboo
let g:peekaboo_window = 'vertical botright 60new'

" vim-projectionist
let g:projectionist_heuristics = {}
let g:projectionist_heuristics['mix.exs'] = {
      \ 'apps/*/mix.exs': { 'type': 'app' },
      \ 'lib/*.ex': {
      \   'type': 'lib',
      \   'alternate': 'test/{}_test.exs',
      \   'template': ['defmodule {camelcase|capitalize|dot} do', 'end'],
      \ },
      \ 'test/*_test.exs': {
      \   'type': 'test',
      \   'alternate': 'lib/{}.ex',
      \   'template': [
      \       'defmodule {camelcase|capitalize|dot}Test do',
      \       '  use ExUnit.Case',
      \       '',
      \       '  alias {camelcase|capitalize|dot}, as: Subject',
      \       '',
      \       '  doctest Subject',
      \       'end'
      \   ],
      \ },
      \ 'mix.exs': { 'type': 'mix' },
      \ 'config/*.exs': { 'type': 'config' },
      \ '*.ex': {
      \   'makery': {
      \     'lint': { 'compiler': 'credo' },
      \     'test': { 'compiler': 'exunit' },
      \     'build': { 'compiler': 'mix' }
      \   }
      \ },
      \ '*.exs': {
      \   'makery': {
      \     'lint': { 'compiler': 'credo' },
      \     'test': { 'compiler': 'exunit' },
      \     'build': { 'compiler': 'mix' }
      \   }
      \ }
      \ }


" Key mappings =================================================================

" faster escape from insert mode
inoremap jk <ESC>

" add blank lines without ending up in insert mode
map <leader>o o<Esc>
map <leader>O O<Esc>j

" shortcuts for macos clipboard register
map <leader>y "*y
map <Leader>p :set paste<CR>"*p:set nopaste<cr>

" align from visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" align from motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" common alignment shortcuts
map <leader>= :EasyAlign =<cr>
map <leader>; :EasyAlign :<cr>

" quickly clear search highlights
nnoremap <leader><leader> :noh<cr>

" project search using Rg command from vim-fzf
nnoremap \ :Rg<space>

" get to beginning/end of line when in insert mode
imap <C-a> <Esc>I
imap <C-e> <Esc>A

" open a new vertical split and go to it
nnoremap <leader>w <C-w>v<C-w>l

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" fuzzy-find files, buffers, and tags with fzf
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fg :GFiles<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>ft :BTags<cr>
nnoremap <leader>fta :Tags<cr>

" <Tab> behaviour
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
