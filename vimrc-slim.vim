set number        " Line numbers on
set autoread      " Automatically read a file changed outside of vim
set autoindent    " Indentation
set textwidth=100 " Automatic word wrapping. Use setlocal textwidth=80 to change it for a file
set mouse=a       " Automatically enable mouse usage
set mousehide     " Hide the mouse cursor while typing
set cursorline    " Highlight current line
set t_Co=256      " Enable 256 colors
" Search
set ignorecase   " Ignore case sensitive search
set smartcase    " Case sensitive search when uc present
set hlsearch     " Highlight search results
set incsearch    " Find as you type search                             "
" No auto backup
set nobackup
set noswapfile
set nowritebackup
" Unnamed clipboard
if has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  set clipboard+=unnamed
endif
" Tabs. More settings here: http://tedlogan.com/techblog3.html
set softtabstop=2
set shiftwidth=2
set expandtab
" Show hidden characters
set list
set listchars=tab:→\ ,eol:↵,trail:•,extends:↷,precedes:↶
" Folds
set foldenable
set foldmethod=indent
set foldlevelstart=20
set foldmarker={,}
"{ Remappings
" Escape
inoremap jk <ESC>
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
"} End of Remappings
call plug#begin('~/.vim/plugged')
"{ VIM functionality plugins
Plug 'tpope/vim-sensible'             " VIM Sensible defaults that everybody agrees on
Plug 'jiangmiao/auto-pairs'           " Insert or delete brackets, parens, quotes in pair
Plug 'godlygeek/tabular'              " http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plug 'freitass/todo.txt-vim'
Plug 'ntpeters/vim-better-whitespace' " Strip whitespaces
Plug 'tpope/vim-commentary'
" status and tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

"{ NERDTree
Plug 'scrooloose/nerdtree'
" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/Dropbox/vim/NERDTreeBookmarks")
" Automatically close a tab if the only remaining window is NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open on right
let g:NERDTreeWinPos = "right"
" Making it prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

map <F2> :NERDTreeToggle<CR>
map <space>ft :NERDTreeToggle<CR>
"} END of NERDTree
"{ TMUX
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator' " Provides C-hjkl shortcuts in vim
"} End of TMUX
"{ Autocompletion
" https://github.com/ervandew/supertab
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"
"} End of Autocomletion

"} END of VIM functionality plugins
"{ Colorshemes
Plug 'chriskempson/base16-vim'
"}
"{ Files
" fzf is a general-purpose command-line fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

let g:fzf_command_prefix = 'Fz' " Same prefix to all commands

imap <C-f> <plug>(fzf-complete-line)
nnoremap <c-p> :FzFiles<CR>
"}

"{ Languages

"{ Terraform
Plug 'hashivim/vim-terraform'
let g:terraform_align=1
let g:terraform_fmt_on_save=1
let g:terraform_commentstring='# %s'
"} END of Terraform

"} End of Languages
call plug#end()

" Take the base16 colortheme
" base16-gruvbox-dark-hard IS the theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
"" Show text rulers - Highlight column 80, 100 as well as 120 and onward
"" http://stackoverflow.com/questions/2447109/showing-a-different-background-colour-in-vim-past-80-characters
let &colorcolumn="80,100,".join(range(120,999),",")
"}
