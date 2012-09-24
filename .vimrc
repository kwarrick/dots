set nocompatible
let mapleader = ","
set visualbell

"" Plugins
call pathogen#infect()          " pathogen

autocmd vimenter * if !argc() | NERDTree | endif
let NERDTreeMinimalUI=1
let NERDTreeWinPos="right"
nmap <silent> <leader>t :NERDTreeToggle<CR>

map <leader>c <c-_><c-_>        " tComment

"" Display
syntax enable

if has('gui_running')
  set background=dark
  " colorscheme solarized
  " colorscheme vividchalk
  " colorscheme railscasts
  " colorscheme github
  colorscheme blackboard
  set guifont=Monaco:h16
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

"" Shortcuts
nmap <leader>l :set list!<CR>   " show newslines and tabs
set listchars=tab:▸\ ,eol:¬     " set newline and tab chars

nnoremap <leader>v <C-w>v       " vertical split
nnoremap <leader>s <C-w>s       " horizontal split

nnoremap <leader>f <C-^>        " goto previous file

nnoremap <leader>n :noh<CR>     " no highlight
