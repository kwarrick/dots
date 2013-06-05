
set nocompatible
filetype off
set visualbell

"" Plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/syntastic'
Bundle 'flazz/vim-colorschemes'

autocmd vimenter * if !argc() | NERDTree | endif
let NERDTreeMinimalUI=1
let NERDTreeWinPos="right"

"" Display
syntax enable

if has('gui_running')
  if has("gui_gtk2")
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=l  "remove left-hand scroll bar
    set guioptions-=b  "remove bottom scroll bar
    set guifont=Source\ Code\ Pro\ 12
  elseif has("gui_macvim")
    set guifont=Source_Code_Pro:h16
  end  

  set background=dark
  colorscheme blackboard
endif

set number
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Key Bindings
let mapleader = ","

imap jj <esc>

nmap <silent><leader>t :NERDTreeToggle<CR>
map <leader>c <c-_><c-_>        " tComment

nmap <leader>l :set list!<cr>   " show newslines and tabs
set listchars=tab:▸\ ,eol:¬     " set newline and tab chars

nnoremap <leader>v <C-w>v       " vertical split
nnoremap <leader>s <C-w>s       " horizontal split

nnoremap <leader>f <C-^>        " goto previous file
nnoremap <leader>q :q<cr>       " quit
nnoremap <leader>w :w<cr>       " write
nnoremap <leader>wq :wq<cr>     " write,quit

nnoremap <leader>n :noh<cr>     " no highlight
