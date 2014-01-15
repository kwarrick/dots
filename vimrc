set nocompatible
set visualbell
set encoding=utf-8
set history=100

"" Plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdtree'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/syntastic'
Bundle 'flazz/vim-colorschemes'

Bundle 'vim-ruby/vim-ruby'
Bundle 'derekwyatt/vim-scala'

Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'

" Bundle 'Valloric/YouCompleteMe'

autocmd vimenter * if !argc() | NERDTree | endif
let NERDTreeMinimalUI=1
let NERDTreeWinPos='right'
let NERDTreeIgnore = ['\.pyc$']

let g:ctrlp_cmd = 'CtrlPMRU'    " default to mru file mode

imap <C-k> <Plug>snipMateNextOrTrigger

"" Display
syntax enable                   " syntax highlighting
filetype on
filetype indent on              " load file type specific indentation
filetype plugin on              " load file type specific plugins 

if has('mouse')
  set mouse=a
end

if has('gui_running')
  if has("gui_macvim")
    set guifont=Source\ Code\ Pro:h18
  elseif has("gui_gtk2")
    set guioptions-=T           "remove toolbar
    set guioptions-=r           "remove right-hand scroll bar
    set guioptions-=l           "remove left-hand scroll bar
    set guioptions-=b           "remove bottom scroll bar
    set guifont=Source\ Code\ Pro\ 14
  end  

  set background=dark
  colorscheme blackboard
endif

set number                      " line numbers
set showcmd                     " display incomplete commands
set listchars=tab:▸\ ,eol:¬     " set newline and tab chars

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive ...
set smartcase                   " ... unless they contain at least one capital letter

"" Key Bindings
let mapleader = ","

" NERDTree
nnoremap <silent><leader>t :NERDTreeToggle<CR>

" tComment
map <leader>c <c-_><c-_>

" Tagbar
nnoremap <leader>r :TagbarToggle<CR>

" no highlight
nnoremap <leader>n :noh<cr>

" show newslines and tabs
nnoremap <leader>l :set list!<cr>

" vertical/horizontal split
nnoremap <leader>v <C-w>v
nnoremap <leader>s <C-w>s

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

" no escape
inoremap <Esc> <Nop>
inoremap <C-k> <Esc>

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

"" Abbreviations
" common command mistakes
cabbrev W w 
cabbrev Q q
cabbrev E e

"" Functions
function! InsertTabWrapper() " tab OR autocomplete
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k' 
        " return "\<tab>"
        return "  "
    else
        return "\<c-n>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

function! g:ToggleColorColumn()
  if &colorcolumn != ''
    setlocal colorcolumn&
  else
    setlocal colorcolumn=+1
  endif
endfunction
nnoremap <silent> <leader>h :call g:ToggleColorColumn()<cr>
 
