set nocompatible
set encoding=utf-8
set history=100
set wildmenu
filetype off

let mapleader = ","

"" Plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Plugin 'SirVer/ultisnips'
Plugin 'ervandew/supertab'
Plugin 'vim-syntastic/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'

" NERDTree
map <leader>t :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" tComment
Plugin 'tomtom/tcomment_vim'
map <leader>c <c-_><c-_>

" Tagbar
Plugin 'majutsushi/tagbar'
nnoremap <leader>r :TagbarToggle<CR>

" Powerline
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set laststatus=2

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsEditSplit="horizontal"

" Appearance
syntax enable                   " syntax highlighting
filetype on
filetype indent on              " load file type specific indentation
filetype plugin on              " load file type specific plugins

set noswapfile

if has('mouse')
  set mouse=a
end

if has('gui_running')
  if has("gui_macvim")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h14
  elseif has("gui_gtk2")
    set guioptions-=T           "remove toolbar
    set guioptions-=r           "remove right-hand scroll bar
    set guioptions-=l           "remove left-hand scroll bar
    set guioptions-=b           "remove bottom scroll bar
    set guifont=Source\ Code\ Pro\ for\ Powerline\ Regular\ 12
  end

  set background=dark
  colorscheme blackboard
endif

set number                      " line numbers
set showcmd                     " display incomplete commands
set listchars=tab:▸\ ,eol:¬     " set newline and tab chars
set colorcolumn=81              " highlight column 80
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235
set cursorline                  " highlight current line
set cursorcolumn                " highlight current column

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive ...
set smartcase                   " ... unless they contain at least one capital

"" Key Bindings

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" no pipe character for split divider
set fillchars+=vert:\ 

" increase/decrease vsplit size
map <C-l> <C-w>>
map <C-h> <C-w><

" enable shift-tab
inoremap <S-Tab> <Esc><<i

" new lines normal mode
nnoremap <S-Enter> O<ESC>
nnoremap <Enter> o<ESC>

" touch of emacs
inoremap <C-a> <Home>
inoremap <C-e> <End>

" visual select pasted text
nnoremap gp `[v`]

" emacs  command line
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>

" toggles
nmap \h :noh <CR>
nmap \n :setlocal number!<CR>
nmap \l :set list!<cr>
nmap \p :set paste!<CR>
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

"" Abbreviations
" common command mistakes
cabbrev W w
cabbrev Q q
cabbrev E e

" File Customizations
if has("autocmd")
  filetype on
  autocmd FileType html setlocal wrap linebreak spell spelllang=en_us
  autocmd FileType markdown setlocal wrap linebreak spell spelllang=en_us
  autocmd FileType txt setlocal wrap linebreak spell spelllang=en_us
  autocmd BufNewFile,BufRead *.ejs set filetype=html
endif
