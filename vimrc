set nocompatible

syntax enable
filetype plugin indent on
set encoding=utf-8
set backspace=indent,eol,start

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
call plug#end()
