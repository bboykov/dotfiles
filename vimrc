set nocompatible

syntax enable
filetype plugin indent on
set encoding=utf-8
set backspace=indent,eol,start

set mouse=a       " Automatically enable mouse usage
set mousehide     " Hide the mouse cursor while typing

" Display
set number        " Show line numbers
set showmatch     " Highlight matching brace
set modeline      " Read infile vim settings
set wildmenu      " Enhanced command-line completion
set autoread      " Automatically read a file changed outside of vim

" Search
set hlsearch    " Highlight all search results
set incsearch   " Searches for strings incrementally

" Identation. More settings here: http://tedlogan.com/techblog3.html
set autoindent    " Indentation
set smarttab      " Enable smart-tabs
set smartindent   " Enable smart-indent
set expandtab     " Use spaces instead of tabs
set softtabstop=2 " Number of auto-indent spaces
set shiftwidth=2  " Number of spaces per Tab

" No auto backup
set nobackup
set noswapfile
set nowritebackup

" Ensure junegunn/vim-plug is installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'freitass/todo.txt-vim'

" Issue https://github.com/chriskempson/base16-vim/issues/197
" Pull Request https://github.com/chriskempson/base16-vim/pull/198
Plug 'danielwe/base16-vim'

" Status and tabline for vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

Plug 'yggdroot/indentline'

" tmux integrations
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'roxma/vim-tmux-clipboard'

" git integrations
Plug 'tpope/vim-fugitive'           " Git wrapper
Plug 'tpope/vim-rhubarb'            " GitHub extension for fugitive.vim
Plug 'mhinz/vim-signify'            " Git diff in the sign column

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Automatically close a tab if the only remaining window is NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinPos = "right"
let NERDTreeMinimalUI = 1 " Making it prettier
let NERDTreeDirArrows = 1 " Making it prettier
map <space>ft :NERDTreeToggle<CR>

call plug#end()

" Load base16 shell theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Remappings
" Quit vim without saving
nnoremap <space>q  :q<CR>
nnoremap <space>Q  :qa!<CR>
" Quick command mode
nnoremap ; :
" Redo
nnoremap U <C-r>
" Visual shifting (does not exit Visual mode). Keeps the selection in place
vnoremap < <gv
vnoremap > >gv
" Spell check
set nospell
set spelllang=en_us
nmap <silent> <space>sp :setlocal spell!<CR>
" Buffers
" To open a new empty buffer. This replaces :tabnew which I used to bind to this mapping
nmap <space>bN :enew<cr>
" Move to the next buffer
nmap <space>bn :bnext<CR>
" Move to the previous buffer
nmap <space>bp :bprevious<CR>
" Close the current buffer and move to the previous one. This replicates the idea of closing a tab
nmap <space>bd :bp <BAR> bd #<CR>
" Open the previously opened buffer
nmap <space><Tab> :b#<CR>
" Show all open buffers and their status
nmap <space>bl :ls<CR>
" Edit vimrc
nnoremap <space>fed :vsplit $MYVIMRC<cr>
" Source vimrc
nnoremap <space>fds :source $MYVIMRC<cr>
" Open my GTD files
nnoremap <space>fet :sp $HOME/notes/todo-txt/todo.txt<cr>
" Insert current date with week day
nnoremap <space>tT "=strftime("%a %Y-%m-%d")<CR>P
inoremap <space>tT <C-R>=strftime("%a %Y-%m-%d")<CR>
" Insert current date without week day
nnoremap <space>tt "=strftime("%Y-%m-%d")<CR>P
inoremap <space>tt <C-R>=strftime("%Y-%m-%d")<CR>
