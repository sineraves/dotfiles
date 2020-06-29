" General ======================================================================

" a mighty good leader
let mapleader = ","

if !has('nvim') " load sensible neovim defaults on regular vim
  set encoding=utf-8
  silent! runtime sensible.vim
endif

" disable rspec plugin in polyglot as it messes with linting
" must be done before loading packages
let g:polyglot_disabled = ['rspec']

runtime packages.vim

let g:loaded_netrwPlugin = 1

let g:python3_host_prog = '/usr/local/bin/python3'
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

if has("nvim")
  set inccommand=nosplit          " live substitution preview
end
if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent                 " when wrapping, indent the lines
  set breakindentopt=sbr
endif

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

augroup vimrcEx
  autocmd!
  " Auto create directories for new files.
  au BufWritePre,FileWritePre * call mkdir(expand('<afile>:p:h'), 'p')

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{babel,jshint,eslint,stylelint}rc set filetype=json
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

" let g:ale_completion_enabled = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 100
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
let g:ale_virtualtext_cursor = 1

" ale: linters
let g:ale_linters = {
      \ 'css': ['stylelint'],
      \ 'javascript': ['eslint'],
      \ 'python': ['flake8'],
      \ 'ruby': ['rubocop', 'rails_best_practices'],
      \ 'scss': ['stylelint'],
      \}

" ale: fixers (overwrites files on save)
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'css': ['stylelint'],
      \ 'javascript': ['eslint'],
      \ 'python': ['black'],
      \ 'ruby': ['rubocop'],
      \ 'scss': ['stylelint'],
      \}

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
      \ 'vendor'
      \]

" vim-peekaboo
let g:peekaboo_window = 'vertical botright 60new'

" vim-projectionist
let g:projectionist_heuristics = {}
" Rails
let g:projectionist_heuristics['config/environment.rb'] = {
      \ 'app/*.rb': {
      \   'alternate': 'spec/{}_spec.rb'
      \ },
      \ 'lib/*.rb': {
      \   'alternate': 'spec/lib/{}_spec.rb'
      \ },
      \ 'spec/lib/*_spec.rb': {
      \   'alternate': 'lib/{}.rb'
      \ },
      \ 'spec/*_spec.rb': {
      \   'alternate': 'app/{}.rb'
      \ }
      \}

let g:AutoPairsMapCR=0
inoremap <silent> <Plug>(MyCR) <CR><C-R>=AutoPairsReturn()<CR>
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<Plug>(MyCR)", 'im')

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
nnoremap <leader>fh :History<cr>

" <Tab> behaviour
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" go to next ale issue
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>
