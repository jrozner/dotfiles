" Shared config for Neovim and Vim. Settings that are already Neovim
" defaults are kept when Vim (especially older versions) needs them.

if &compatible
  set nocompatible
endif

" Must be set before anything that depends on multibyte handling.
" Neovim is always utf-8; Vim otherwise follows the locale.
set encoding=utf-8
scriptencoding utf-8

" Auto Commands
if has("autocmd")
  " enable filetype detection
  filetype plugin indent on
endif

if has('eval')
  let mapleader = "\<Space>"
endif

nnoremap <silent> <leader>bn :bn<CR>
nnoremap <silent> <leader>bp :bp<CR>
nnoremap <silent> <leader>bl :ls<CR>
nnoremap <silent> <leader>bb :ls<CR>:b
nnoremap <leader>bo :badd<space>

" Tabbing
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
nnoremap <silent> <leader>t :retab<CR>

" Appearance
set ruler
set number
set title
if has('termguicolors')
  set termguicolors
endif
set background=dark

" Re-apply custom highlights whenever a colorscheme loads. Neovim uses the
" Whitespace group for tab/trail listchars; Vim uses SpecialKey.
augroup MyColors
  autocmd!
  autocmd ColorScheme * hi StatusLine ctermfg=33 ctermbg=8 guifg=#268bd2 guibg=#002b36
                    \ | hi SpecialKey ctermfg=red ctermbg=NONE guifg=red guibg=NONE
                    \ | hi Whitespace ctermfg=red ctermbg=NONE guifg=red guibg=NONE
augroup END

if has('syntax')
  syntax enable
endif
if has('eval')
  try
    colorscheme solarized8
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
  endtry
endif

set laststatus=2
if has('eval') && has('statusline')
  set statusline=%{Mode()}\ %F\ %m%r%w\ %=%{&ff}\ %{&fileencoding?&fileencoding:&encoding}\ %Y\ %p%%\ %l:%v
endif
set noshowmode

" Searching
set hlsearch
nnoremap <silent> <leader><space> :noh<CR>

" Misc
set backspace=eol,start,indent
set autoindent
set modelines=0 "disable the use of modelines
if has('clipboard')
  set clipboard=unnamed,unnamedplus
endif

" Spell Checking
set spelllang=en_us
nnoremap <silent> <leader>s :set spell!<CR>

" Show Invisibles
set list
set listchars=tab:▸\ ,eol:¬,trail:.
nnoremap <silent> <leader>l :set list!<CR>

" Line Wrapping
set wrap
set linebreak

" wildmenu
set wildmenu
set wildmode=list:longest,full

" vim.tiny (no +eval) skips everything inside if/endif.
if has('eval')

" Shamelessly stolen from https://github.com/maciakl/vim-neatstatus/blob/master/after/plugin/neatstatus.vim
function! Mode()
  let l:mode = mode()

  if     l:mode ==# "n"  | return "NORMAL"
  elseif l:mode ==# "i"  | return "INSERT"
  elseif l:mode ==# "R"  | return "REPLACE"
  elseif l:mode ==# "v"  | return "VISUAL"
  elseif l:mode ==# "V"  | return "V-LINE"
  elseif l:mode ==# "\<C-v>" | return "V-BLOCK"
  else                   | return l:mode
  endif
endfunc

" Refresh the statusline on mode changes (replaces the old redraw hack).
if exists('##ModeChanged')
  augroup MyStatusline
    autocmd!
    autocmd ModeChanged * redrawstatus
  augroup END
endif

endif
