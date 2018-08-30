set number        " Line numbers on
set autoread      " Automatically read a file changed outside of vim
set autoindent    " Indentation
set textwidth=100 " Automatic word wrapping. Use setlocal textwidth=80 to change it for a file
set mouse=a       " Automatically enable mouse usage
set mousehide     " Hide the mouse cursor while typing
set cursorline    " Highlight current line
set t_Co=256      " Enable 256 colors
set splitright    " Puts new vsplit windows to the right of the current
set splitbelow    " Puts new split windows to the bottom of the current
set hidden " This allows buffers to be hidden if you've modified a buffer.
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
" Abbreviations
" Insert date
inoreabbrev Tdate <c-r>=strftime("%Y-%m-%d")<cr>
" }
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
"} End of Remappings
call plug#begin('~/.vim/plugged')
"{ VIM functionality plugins
Plug 'tpope/vim-sensible'             " VIM Sensible defaults that everybody agrees on
Plug 'jiangmiao/auto-pairs'           " Insert or delete brackets, parens, quotes in pair
Plug 'godlygeek/tabular'              " http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plug 'freitass/todo.txt-vim'
Plug 'ntpeters/vim-better-whitespace' " Strip whitespaces
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround' " Provides mappings to delete, change and add surroundings in pairs.
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
"{ Colorshemes and looks
Plug 'chriskempson/base16-vim'
Plug 'yggdroot/indentline' " display the indention levels with thin vertical lines
"}
"{ Files
" fzf is a general-purpose command-line fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_command_prefix = 'Fz' " Same prefix to all commands
" Mapping selecting mappings
nmap <space><tab>? <plug>(fzf-maps-n)
xmap <space><tab>? <plug>(fzf-maps-x)
omap <space><tab>? <plug>(fzf-maps-o)
" Insert mode completion
imap <space><c-k> <plug>(fzf-complete-word)
imap <space><c-f> <plug>(fzf-complete-path)
imap <space><c-j> <plug>(fzf-complete-file-ag)
imap <space><c-l> <plug>(fzf-complete-line)

nnoremap <space>ff :FzFiles<CR>
nnoremap <space>bB :FzBuffers<CR>
nnoremap <space>bW :FzWindows<CR>
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
