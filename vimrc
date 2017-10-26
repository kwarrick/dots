set nocompatible
set encoding=utf-8
set history=100
set wildmenu
filetype off

" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'
Plugin 'flazz/vim-colorschemes'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale'

" NERDTree
Plugin 'scrooloose/nerdtree'
nmap ,t :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Tagbar
Plugin 'majutsushi/tagbar'
nnoremap ,r :TagbarToggle<CR>

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
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsEditSplit="horizontal"

" FZF
Plugin 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf
nmap <Space>b :Buffers<CR>
nmap <Space>t :Files<CR>
nmap <Space>r :Tags<CR>
nmap <Space>f :Marks<CR>
nmap <Space>g :Ag<CR>

" ALE
nmap <Leader>s :ALEToggle<CR>

call vundle#end()

" Appearance
syntax enable                             " syntax highlighting
filetype on
filetype indent on                        " load file type specific indentation
filetype plugin on                        " load file type specific plugins

set noswapfile

if has('mouse')
  set mouse=a
end

set number                                " line numbers
set showcmd                               " display incomplete commands
set listchars=tab:▸\ ,eol:¬               " set newline and tab chars
set cursorline                            " highlight current line
set colorcolumn=81                        " highlight column 80
highlight ColorColumn ctermbg=235
let &colorcolumn=join(range(81,999),",")

"" Whitespace
set nowrap                                " don't wrap lines
set tabstop=2 shiftwidth=2                " a tab is two spaces
set expandtab                             " use spaces, not tabs
set backspace=indent,eol,start            " backspace everything in insert mode

" highlight trailing whitespace
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+\%#\@<!$/

" no pipe character for split divider
set fillchars+=vert:\ 

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive ...
set smartcase                   " ... unless they contain at least one capital

"" Key Bindings

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
nmap <Leader>h :noh <CR>
nmap <Leader>n :setlocal number!<CR>
nmap <Leader>l :set list!<CR>
nmap <Leader>p :set paste!<CR>
nmap <Leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap <Leader>T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap <Leader>M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap <Leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap <Leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>

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
  autocmd filetype crontab setlocal nobackup nowritebackup
endif
