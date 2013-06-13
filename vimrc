
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
Bundle 'mileszs/ack.vim'
Bundle 'majutsushi/tagbar'

autocmd vimenter * if !argc() | NERDTree | endif
let NERDTreeMinimalUI=1
let NERDTreeWinPos='right'

"" Display
syntax enable

if has('gui_running')
  set background=dark
  set guifont=Source_Code_Pro:h18
  colorscheme blackboard
  " colorscheme solarized
  " colorscheme vividchalk
  " colorscheme railscasts
  " colorscheme github
endif

set number                      " line numbers
set showcmd                     " display incomplete commands
set encoding=utf-8
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
nmap <leader>c <c-_><c-_>        " tComment

nmap <leader>r :TagbarToggle<CR>" tagbar

nmap <leader>l :set list!<cr>   " show newslines and tabs
set listchars=tab:▸\ ,eol:¬     " set newline and tab chars

nnoremap <leader>v <C-w>v       " vertical split
nnoremap <leader>s <C-w>s       " horizontal split

nnoremap <leader>f <C-^>        " goto previous file
nnoremap <leader>q :q<cr>       " quit
nnoremap <leader>w :w<cr>       " write
nnoremap <leader>wq :wq<cr>     " write,quit

nnoremap <leader>n :noh<cr>     " no highlight

map <C-l> <C-w>>
map <C-h> <C-w><

