sy on

"Search
set ignorecase
set incsearch
set nowrapscan

"Wildmenu
set wildmode=list:longest,full
set wildmenu
set wildignorecase

"Make O not lag that much
set timeout timeoutlen=5000 ttimeoutlen=100

"Indentation
set expandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=2
set tabstop=2

"Open split windows from the right side
set splitright

set list

"Always show status bar (Even when one file is openned)
set laststatus=2

set listchars=tab:▸\ ,eol:¬,trail:.
set history=1000

syntax sync minlines=256
set synmaxcol=2048

set clipboard=unnamed,unnamedplus
set noswapfile
set mouse=""

"NeoBundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neomake/neomake'

Plug 'dmitry12/heroku-colorscheme'

Plug 'bolasblack/csslint.vim'
Plug 'SirVer/ultisnips'
Plug 'vim-scripts/CmdlineComplete'
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmhedberg/matchit'

Plug 'honza/vim-snippets'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'

Plug 'jelera/vim-javascript-syntax'
Plug 'othree/html5.vim'
Plug 'airblade/vim-rooter'
Plug 'groenewege/vim-less'

Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'sbdchd/neoformat'

Plug 'itchyny/lightline.vim'
Plug 'elmcast/elm-vim'
Plug 'styled-components/vim-styled-components'

call plug#end()

set background=dark

colorscheme heroku-terminal

"Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif

"Less syntax support
au BufNewFile,BufRead *.less set filetype=less
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.js set ft=javascript.jsx

"Highlight all trailing white spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"And remove on save
autocmd BufWritePre * :%s/\s\+$//e

"Alwaes stay in the middle of the screen
let &scrolloff=999-&scrolloff

command! WQ wq
command! Wq wq
command! W w
command! Q q
cmap w!! w !sudo tee > /dev/null %

nnoremap s :w<CR>
"TODO: Add variable to determine current position, and then get back to it
nnoremap <C-Space> :tabe %<CR>:tabp<CR>:q<CR>:tabn<CR>
nnoremap <C-@> <C-Space>

let mapleader=" "
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>l :set list!<CR>
nnoremap <leader>pr :TagbarToggle<CR>
nnoremap <leader>c :let @/ = ''<CR>

nnoremap <leader><leader> :call fzf#run({ 'sink': 'e', 'window': 'rightbelow new' })<CR>

"Paste in visual mode without copying
xnoremap p pgvy

nnoremap X "_x
vnoremap X "_x

nnoremap j gj
nnoremap k gk

nnoremap H gT
nnoremap L gt

nnoremap K i<CR><Esc>

nnoremap gp `[v`]

nnoremap S :w<CR>:call VimuxRunCommand('~/bin/sync')<CR><CR>

nnoremap <Leader>tu :vs <C-R>=substitute(substitute(expand("%:p"), "\/colourbox", "\/colourbox\/tests/unit", ""), "\.php", "Test.php", "")<CR> <CR>

nnoremap Q nop

hi StatusLine   ctermfg=15  guifg=#ffffff ctermbg=56 guibg=#5f00d7 cterm=bold gui=bold

"nnoremap <leader>b :ls<CR>:b<space>
nnoremap <leader>b :Buffers<CR>

highlight DiffAdd cterm=none ctermfg=Black ctermbg=Green gui=none guifg=fg guibg=Blue
highlight DiffDelete cterm=none ctermfg=Black ctermbg=Red gui=none guifg=fg guibg=Blue
highlight DiffChange cterm=none ctermfg=Black ctermbg=Blue gui=none guifg=fg guibg=Blue
highlight DiffText cterm=none ctermfg=Black ctermbg=Yellow gui=none guifg=bg guibg=White

set diffopt+=iwhite

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let NERDTreeIgnore = ['\.tmp.js$']
nnoremap <leader>a :NERDTree %:h<CR>

nnoremap <leader>cwd :cd %:h<CR>
nnoremap <leader>cd :Rooter<CR>

let g:rooter_manual_only = 1 " To stop vim-rooter changing directory automatically

autocmd FileType javascript setlocal omnifunc=tern#Complete

"When using filesystem autocomplete, first cd to relative folder to file and then autocomplete
inoremap <C-X><C-F> <ESC>:cd %:h<CR>a<C-X><C-F>


augroup active_relative_number
  au!
  au BufEnter * :setlocal number
  au WinEnter * :setlocal number
  au BufLeave * :setlocal nonumber
  au WinLeave * :setlocal nonumber
augroup END

let g:fzf_layout = {}

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

"http://vim.wikia.com/wiki/Git_grep
func! GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

function! GetVisuallySelectedText()
  " Stolen from http://stackoverflow.com/a/6271254/794380
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]

  return join(lines, "\n")
endfunction

function! GitGrepVisuallySelectedText()
  let input = GetVisuallySelectedText()

  execute "tabe"
  execute "set hidden"
  execute "r!git grep -i " . input . " *"
endfunction

xnoremap <leader>G :call GitGrepVisuallySelectedText()<CR>

set suffixesadd=.es,.js,.jsx,.elm

" Run NeoMake on read and write operations
 autocmd! BufReadPost,BufWritePost * Neomake

" Disable inherited syntastic
"let g:syntastic_mode_map = {
"  \ "mode": "passive",
"  \ "active_filetypes": [],
"  \ "passive_filetypes": [] }
"
" if findfile('node_modules/.bin/eslint', '.;') !=# ''
" "  let g:syntastic_javascript_checkers = ['eslint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'
" endif

let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1

let g:neomake_open_list=0

autocmd Filetype elm setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
set includeexpr=substitute(v:fname,'\\.','/','g')

highlight clear SignColumn

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

nnoremap <leader>f :!./node_modules/.bin/eslint --fix %<CR><CR>
let g:deoplete#enable_at_startup = 1

"nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
set completeopt=menuone,longest
language en_US

augroup Cursoractive
    au!
    autocmd VimEnter, WinEnter, BufWinEnter * set local cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
"let g:javascript_plugin_flow = 1

nnoremap [[ :lprev<CR>
nnoremap ]] :lnext<CR>
nnoremap <CR> :ll<CR>

let @w = '$hx%lx%i^[oreturn {^[%O}^[V%=s'

let g:twiggy_group_locals_by_slash = 0
let g:twiggy_local_branch_sort = 'mru'
let g:twiggy_remote_branch_sort = 'date'

"let g:lightline = {
"      \ 'component_function': {
"      \   'flow': 'LightlineFlowCoverage',
"      \ },
"      \ }

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'inactive': {
      \   'left': [ [ 'full_filename', 'readonly', 'modified' ] ],
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'full_filename', 'readonly', 'modified' ] ],
      \   'right': [ [ 'hi' ] ]
      \ },
      \ 'component': {
      \   'hi': 'hello',
      \ },
      \ 'component_function': {
      \   'full_filename': 'GetFullFilename'
      \ },
      \ }

function! GetFullFilename()
  return expand('%')
endfunction

au BufNewFile,BufRead *.pn set filetype=potion

set noshowmode

let g:elm_format_autosave = 1
