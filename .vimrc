if &compatible
  set nocompatible
endif

set runtimepath+=/Users/joe/.vim/repos/github.com/Shougo/dein.vim

call dein#begin('/Users/joe/.vim')

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-go')
call dein#add('jreybert/vimagit')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-haml')
call dein#add('pangloss/vim-javascript')
call dein#add('kchmck/vim-coffee-script')
call dein#add('vim-ruby/vim-ruby')
call dein#add('elzr/vim-json')
call dein#add('fatih/vim-go')
call dein#add('nsf/gocode')
call dein#add('jrozner/vim-antlr')
call dein#add('hail2u/vim-css3-syntax')
call dein#add('ap/vim-css-color')
call dein#add('majutsushi/tagbar')
call dein#add('airblade/vim-gitgutter')
call dein#add('rust-lang/rust.vim')
call dein#add('altercation/vim-colors-solarized')
call dein#add('racer-rust/vim-racer')

call dein#end()

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" Auto Commands
if has("autocmd")
  " enable filetype detection
  filetype plugin indent on

  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  autocmd FileType go set noexpandtab
  let g:go_fmt_command = "goimports"
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1

  au FileType go nmap <Leader>s <Plug>(go-implements)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <Leader>gd <Plug>(go-doc)
  au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
  au FileType go nmap <leader>r <Plug>(go-run)
  au FileType go nmap <leader>b <Plug>(go-build)
  au FileType go nmap <leader>t <Plug>(go-test)
  au FileType go nmap <leader>c <Plug>(go-coverage)
  au FileType go nmap <Leader>ds <Plug>(go-def-split)
  au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dt <Plug>(go-def-tab)
  au FileType go nmap <Leader>e <Plug>(go-rename)

  let g:rustfmt_autosave = 1
  let g:racer_experimental_completer = 1

  let g:deoplete#enable_at_startup = 1
endif

let mapleader = "\ "

nmap <silent><leader>bn :bn<CR>
nmap <silent><leader>bp :bp<CR>
nmap <silent><leader>bl :ls<CR>
nmap <silent><leader>bb :ls<CR>:b
nmap <leader>bo :badd<space>

"nmap <silent><leader>b :Gblame<CR>
nmap <silent><leader>ct :TagbarToggle<CR>

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
colorscheme solarized
set background=dark
syntax enable
set nocursorline
set nocursorcolumn
set t_Co=256
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

" Tabs
nmap <leader>n :tabnew<CR>

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
