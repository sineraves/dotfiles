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

let g:python3_host_prog = expand('~/.asdf/shims/python3')
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
" support embedded syntax for lua, python, and ruby
let g:vimsyn_embed= 'lPr'

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


" Search =======================================================================

set ignorecase smartcase          " ignore case when search query lowercase
set wrapscan                      " searches wrap around file
if executable('rg')               " use rg for `grep` command (but prefer `:Rg`)
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif


" Neovim terminal ==============================================================

if has('nvim')
  " Make difference between vim and term cursors clearer
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15

  " Avoid nesting nvim instances when opening files from within `:terminal`,
  " either manually, or via commands that use `$VISUAL` (eg `git commit`)
  " Requires https://github.com/mhinz/neovim-remote
  if executable('nvr')
    let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
  endif
endif


" Language servers =============================================================

highlight LspWarningHighlight gui=underline
highlight LspInformationHighlight gui=underline
highlight LspErrorHighlight gui=underline
highlight link LspWarningText WarningMsg
highlight link LspInformationText Todo
highlight link LspErrorText ErrorMsg

highlight mkdLineBreak guifg=none guibg=none

set signcolumn=yes
call sign_define("LspDiagnosticsErrorSign", {"text" : "●", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "●", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "●", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "●", "texthl" : "LspDiagnosticsHint"})

let g:diagnostic_virtual_text_prefix = ''
let g:diagnostic_enable_virtual_text = 1
let g:space_before_virtual_text = 1
let g:diagnostic_insert_delay = 1

" Configure LSP in lua
:lua require'lsp'

" Trigger completion with <tab>
" found in :help completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Language-specific config =====================================================

let g:rustfmt_autosave = 1

" Plugin Configuration =========================================================

" vim-airline
if $ITERM_PROFILE == 'light'
  let g:airline_theme = 'tomorrow'
else
  let g:airline_theme = 'zenburn'
endif
let g:airline_powerline_fonts = 1

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

" vim-test
let test#strategy = 'dispatch'
let test#ruby#rspec#executable = 'docker-compose exec web ./bin/rspec'

" Key mappings =================================================================

" faster escape from insert mode
inoremap jj <ESC>

if has('nvim')
  tnoremap jj <C-\><C-n>
endif

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

" Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>
