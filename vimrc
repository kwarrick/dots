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
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tcomment_vim'
Plugin 'scrooloose/syntastic'
Plugin 'flazz/vim-colorschemes'
Plugin 'airblade/vim-gitgutter'

Plugin 'vim-ruby/vim-ruby'
Plugin 'derekwyatt/vim-scala'
Plugin 'fatih/vim-go'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'jgdavey/tslime.vim'

Plugin 'SirVer/ultisnips'

Plugin 'ervandew/supertab'

Plugin 'michaeljsmith/vim-indent-object'

" NERDTree
nnoremap <silent><leader>t :NERDTreeToggle<CR>

" tComment
map <leader>c <c-_><c-_>

" Tagbar
nnoremap <leader>r :TagbarToggle<CR>

" tslime
vmap <leader>e <Plug>SendSelectionToTmux
nmap <leader>e <Plug>NormalModeSendToTmux
nmap <leader>er <Plug>SetTmuxVars

" Powerline
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set laststatus=2

" OCaml Merlin
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
let g:syntastic_ocaml_checkers = ['merlin']

" NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
let NERDTreeMinimalUI=1
let NERDTreeWinPos='right'
let NERDTreeIgnore=['\.pyc$', '__pycache__[[dir]]']

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsEditSplit="horizontal"

"" Display
syntax enable                   " syntax highlighting
filetype on
filetype indent on              " load file type specific indentation
filetype plugin on              " load file type specific plugins

set noswapfile

if has('mouse')
  set mouse=a
end

if has('gui_running')
  set cursorline                  " highlight cursor line

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

" no highlight
nnoremap <leader>n :noh<cr>

" show newslines and tabs
nnoremap <leader>l :set list!<cr>

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" no pipe character for split divider
set fillchars+=vert:\

" increase/decrease vsplit size
map <C-l> <C-w>>
map <C-h> <C-w><

" yank, quit, write, write/quit
nnoremap <leader>y "*y
nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>wq :wq<cr>

" disable arrows
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" enable shift-tab
inoremap <S-Tab> <Esc><<i

" new lines normal mode
nnoremap <S-Enter> O<ESC>
nnoremap <Enter> o<ESC>

" toggle paste mode
set pastetoggle=<leader>p

" touch of emacs
inoremap <C-a> <Home>
inoremap <C-e> <End>

" visual select pasted text
nnoremap gp `[v`]

" emacs  command line
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>

" toggles
nmap \l :setlocal number!<CR>
nmap \o :set paste!<CR>
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
  autocmd FileType ocaml call SuperTabSetDefaultCompletionType("<c-x><c-o>")
  autocmd BufRead /tmp/psql.edit.* setlocal ft=sql
  autocmd BufNewFile,BufRead *.ejs set filetype=html
endif

