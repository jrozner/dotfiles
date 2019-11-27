if &compatible
  set nocompatible
endif

" Auto Commands
if has("autocmd")
  " enable filetype detection
  filetype plugin indent on
endif

let mapleader = "\ "

nmap <silent><leader>bn :bn<CR>
nmap <silent><leader>bp :bp<CR>
nmap <silent><leader>bl :ls<CR>
nmap <silent><leader>bb :ls<CR>:b
nmap <leader>bo :badd<space>

" Tabbing
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
nmap <silent> <leader>t :retab<CR>

" Appearance
set ruler
set number
set title
set termguicolors
set background=light
colorscheme solarized8
syntax enable
set nocursorline
set nocursorcolumn
set laststatus=2
set statusline=%{Mode()}\ %F\ %m%r%w\ %=%{&ff}\ %{&fileencoding?&fileencoding:&encoding}\ %Y\ %p%%\ %l:%v
hi StatusLine ctermfg=33 ctermbg=8
hi SpecialKey ctermfg=red ctermbg=none
set noshowmode

" Searching
set hlsearch
nnoremap <silent> <leader> <space> :noh<CR>

" Misc
set nobackup
set backspace=eol,start,indent
set ai
set si
set modelines=0 "disable the use of modelines
set encoding=utf-8
set ttyfast
set clipboard=unnamed
set iskeyword+=_

" Autocomplete
set ofu=syntaxcomplete#Complete "Enable syntax completion
set completeopt-=preview

" Spell Checking
set spelllang=en_us
nmap <silent> <leader>s :set spell!<CR>

" Show Invisibles
set list
set listchars=tab:▸\ ,eol:¬,trail:.
nmap <silent> <leader>l :set list!<CR>

" Line Wrapping
set wrap
set linebreak

" wildmenu
set wildmenu
set wildmode=list:longest,full

" Shamelessly stolen from https://github.com/maciakl/vim-neatstatus/blob/master/after/plugin/neatstatus.vim
function! Mode()
  redraw
  let l:mode = mode()

  if     mode ==# "n"  | return "NORMAL"
  elseif mode ==# "i"  | return "INSERT"
  elseif mode ==# "R"  | return "REPLACE"
  elseif mode ==# "v"  | return "VISUAL"
  elseif mode ==# "V"  | return "V-LINE"
  elseif mode ==# "" | return "V-BLOCK"
  else                 | return l:mode
  endif
endfunc
