" Misc
set nocompatible
set number
set modeline
set textwidth=100

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

if has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  set clipboard+=unnamed
endif


call plug#begin('~/.vim/plugged')
call plug#end()
