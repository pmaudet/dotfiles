""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GLOBAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" VIM, not VI
set nocompatible

" pathogen bundles
filetype off
call pathogen#runtime_append_all_bundles()

" General appearance and behaviour
filetype plugin indent on
syntax on
set visualbell t_vb=
set noerrorbells
set ruler
set showcmd
set showmatch
set wildmenu
set wildmode=list:longest,full
set backspace=indent,eol,start
set nowrap
set linebreak

set nomodeline

" MOUSE with VIM ! (YES)
" set mouse=a
" set ttymouse=xterm2
set scrolloff=1

" Indentation options
set autoindent
set expandtab
set softtabstop=2
set shiftwidth=2
set tabstop=2
set virtualedit=block

set equalprg=
set grepprg=ack\ -ai

" don't insert 2 spaces after punctuation
set nojoinspaces

" Search options
set incsearch
set hlsearch
set ignorecase

" Print options ...
set printoptions=header:0

" vimdiff
set diffopt=filler,iwhite

" This is useful for debugging
" set verbose=9

set spellcapcheck=

if has('gui_running')
  set guioptions=
  set guifont=Inconsolata\ 16
endif

if $TERM == "xterm-256color"
  if $TMUX == ""
    colorscheme 256_xoria
  else
    colorscheme 256_xoria_black " until tmux fixes BCE problems
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F-KEYS MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <F4> :w<CR>:make<CR>:cw<CR>
imap <F4> <ESC><F4>

nmap <F5>   :ToggleSpaceHi<CR>
imap <F5>   <C-o><F5>
nmap <F6>   :set spell!<CR>
imap <F6>   <C-o><F6>
nmap <F7>   :set wrap!<CR>
imap <F7>   <C-o><F7>
nmap <F8>   :set paste!<CR>
imap <F8>   <C-o><F8>

nmap <ESC>l :set list!<CR>
nmap <ESC>n :set number!<CR>
nmap <ESC><SPACE> :nohl<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMMA MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" STRIP -- EMPTY LINE ENDINGS
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
vmap _$ :call Preserve( "s/\\s\\+$//e")<CR>
" STRIP -- EMPTY LINE BEGINNINGS
nmap _^ :call Preserve("%s/^\\s\\+//e")<CR>
vmap _^ :call Preserve( "s/^\\s\\+//e")<CR>

" COMMATIZE
vmap ,, :! paste -s -d, -<CR>
" QUOTISIZE
vmap ,' :! awk '{print "'\''"$0"'\''"}'<CR>
vmap ," :! awk '{print "\""$0"\""}'<CR>
" AWK
vmap ,a :! awk '{print }'<LEFT><LEFT>

" ONLY KEEP LINES WHICH CONTAIN SEARCH
nmap ,v :v/<C-R>//d<CR>gg
nmap ,d :g/<C-R>//d<CR>gg

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <silent> Q :qa<CR>

" buffer list on tab
nmap <tab> :buffers<CR>:buffer<Space>

" easier to reach, overrides TOP and BOTTOM of screen
map H ^
map L $

" display line up/down (not actual)
map <up> gk
map <down> gj

" search next/previous -- center in page
nmap n nzz
nmap N Nzz
nmap * *Nzz

" one-key indentation
nmap > >>
nmap < <<

" nerd commenter
vmap # :call NERDComment(1, "toggle")<CR>
nmap # V#

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SPLIT MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" window
nmap \|<left>  :topleft  vnew<CR>
nmap \|<right> :botright vnew<CR>
nmap \|<up>    :topleft  new<CR>
nmap \|<down>  :botright new<CR>

" buffer
nmap \<left>  :leftabove  vnew<CR>
nmap \<right> :rightbelow vnew<CR>
nmap \<up>    :leftabove  new<CR>
nmap \<down>  :rightbelow new<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SPACEHI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:spacehi_tabcolor="ctermfg=White ctermbg=Red guifg=White guibg=Red"
let g:spacehi_spacecolor="ctermfg=Black ctermbg=Yellow guifg=Blue guibg=Yellow"

autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax * SpaceHi
au FileType help NoSpaceHi
au FileType diff NoSpaceHi
au FileType man  NoSpaceHi
au FileType scratchy NoSpaceHi

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" QUICKFIX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" like vim-unimpaired, but without all that other code
nmap <silent> [q :cprevious<CR>
nmap <silent> ]q :cnext<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

source $VIMRUNTIME/ftplugin/man.vim

" used by :TOhtml
let g:html_use_css=0

" set in variables.sh
let g:sql_type_default=$DB_ADAPTER

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

