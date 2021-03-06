set nocompatible
set encoding=utf-8
set history=100
set wildmenu
set hidden
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set laststatus=2

filetype off

" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'
Plugin 'chriskempson/base16-vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'Valloric/YouCompleteMe'
Plugin 'christoomey/vim-tmux-navigator'

" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Base16 color scheme
let base16colorspace = 256
set termguicolors

" NERDTree
Plugin 'scrooloose/nerdtree'
Plugin 'ryanoasis/vim-devicons'
nmap ,t :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Tagbar
Plugin 'majutsushi/tagbar'
nnoremap ,r :TagbarToggle<CR>

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
Plugin 'w0rp/ale'
nmap <Leader>s :ALEToggle<CR>
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'vue': ['prettier', 'eslint'],
\   'css': ['prettier'],
\   'html': ['prettier'],
\}
let g:ale_fix_on_save = 1

call vundle#end()

" Appearance
syntax enable                             " syntax highlighting
filetype on
filetype indent on                        " load file type specific indentation
filetype plugin on                        " load file type specific plugins
colorscheme base16-default-dark

set noswapfile

if has('mouse')
  set mouse=a
end

set number                                " line numbers
set showcmd                               " display incomplete commands
set listchars=tab:▸\ ,eol:¬               " set newline and tab chars
"set cursorline                            " highlight current line
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
highlight VertSplit cterm=NONE ctermbg=DarkGray

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

" autoformats
vmap g=x !tidy -q -i -xml<CR>`[v`]==<CR>
vmap g=j !python -m json.tool<CR>

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
  autocmd filetype crontab setlocal nobackup nowritebackup
  autocmd FileType sql setlocal commentstring=--\ %s
endif

" Rust
let g:racer_cmd = $HOME."/.cargo/bin/racer"
let g:rustc_path = $HOME."/.cargo/bin/rustc"
let g:rustfmt_autosave = 1
autocmd FileType rust nmap gd <Plug>(rust-def)
autocmd FileType rust nmap gs <Plug>(rust-def-split)
autocmd FileType rust nmap gx <Plug>(rust-def-vertical)
autocmd FileType rust nmap <leader>gd <Plug>(rust-doc)

" Ale highlight colors
highlight ALEError ctermbg=131
highlight ALEWarning ctermbg=90

" tmux-navigator bindings
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr> nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>
