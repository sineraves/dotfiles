" Load plugins """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:plugins = $HOME . '/.dotfiles/vim/plugins.vim'
execute 'source' s:plugins


" Basic options """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ','
set autoread
set hidden
set showcmd
set splitbelow
set splitright


" Presentation """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=light
set colorcolumn=+1
set cursorline
set formatoptions+=tcqjn
set laststatus=2
set list listchars=tab:»·,trail:·,nbsp:·
set nostartofline
set nowrap
set number
set numberwidth=5
set relativenumber
set synmaxcol=800
set textwidth=80

colorscheme solarized

let g:airline_theme = 'solarized'
let g:tmuxline_powerline_separators = 0

highlight link xmlEndTag xmlTag

augroup presentation
  au!

  " set syntax highlighting for specific file types
  au BufRead *.md set filetype=markdown
  au BufRead .{babel,jshint,eslint}rc set filetype=json

  " hard wrap for text-ish files
  au BufRead *.txt,*.markdown,*.md setlocal textwidth=80
augroup END


" Indentation """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent
set expandtab
set preserveindent
set shiftround
set shiftwidth=2
set softtabstop=-1
set smarttab


" Completion """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set complete-=t

let g:gutentags_ctags_executable = '/usr/local/bin/ctags'
let g:gutentags_ctags_exclude = ['node_modules/**', 'vendor/**']

" configure neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"


" Editing """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set backspace=indent,eol,start
set nojoinspaces
let g:html_indent_tags = ['p', 'li']
let g:jsx_ext_required = 0
let g:peekaboo_window = 'vertical botright 60new'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
  \      'extends' : 'jsx',
  \  },
  \}

runtime macros/matchit.vim

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

" strip trailing whitespace, maintaining last search and cursor position.
function! <SID>StripTrailingWhitespace()
    let _s = @/
    let l = line(".")
    let c = col(".")

    %s/\s\+$//e

    let @/=_s
    call cursor(l, c)
endfunction

augroup editing
  au!

  " strip trailing whitespace when saving files
  au BufWritePre * :call <SID>StripTrailingWhitespace()
augroup END


" Searching """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch
set ignorecase
set incsearch
set smartcase
set wrapscan

" quickly clear search highlights
nnoremap <leader><leader> :noh<cr>

" search within a current project using ripgrep, piping the results to fzf
command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --hidden --glob "!.git/" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
nnoremap \ :Rg<space>


" Navigation and movement """"""""""""""""""""""""""""""""""""""""""""""""""""""

set wildmode=longest,list

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

" no arrow keys in normal mode
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" fuzzy-find files and buffers with fzf

nnoremap <leader>f :Files<cr>
nnoremap <leader>gf :GFiles<cr>
nnoremap <leader>bf :Buffers<cr>

augroup navigation
  au!

  " return to same line when re-opening files
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif
augroup END


" Backups etc """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup
set noswapfile
set nowritebackup


" Testing & Linting """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let test#strategy = 'dispatch'
let g:ale_completion_delay = 200
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'ruby': ['reek', 'rubocop']}

nmap <silent> <leader>t :w<CR>:TestNearest<CR>
nmap <silent> <leader>T :w<CR>:TestFile<CR>
nmap <silent> <leader>a :w<CR>:TestSuite<CR>
nmap <silent> <leader>l :w<CR>:TestLast<CR>
nmap <silent> <leader>g :w<CR>:TestVisit<CR>


" Local overrides """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:localConfig = $HOME . '/.vimrc.local'
if filereadable(s:localConfig)
  execute 'source' s:localConfig
endif
