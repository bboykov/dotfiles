" Misc {
set nocompatible  " Make Vim behave in a more useful way
set modeline      " Read infile vim settings
set number        " Line numbers on
set autoread      " Automatically read a file changed outside of vim
set autoindent    " Indentation
set textwidth=100 " Automatic word wrapping. Use setlocal textwidth=80 to change it for a file
set mouse=a       " Automatically enable mouse usage
set mousehide     " Hide the mouse cursor while typing
set cursorline    " Highlight current line
set t_Co=256      " Enable 256 colors
set iskeyword+=-  " Treat dashes as part of word
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
set foldcolumn=2
" }
" Unnamed clipboard
if has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  set clipboard+=unnamed
endif
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
" Insert current date with week day
nnoremap <space>tT "=strftime("%a %Y-%m-%d")<CR>P
inoremap <space>tT <C-R>=strftime("%a %Y-%m-%d")<CR>
" Insert current date without week day
nnoremap <space>tt "=strftime("%Y-%m-%d")<CR>P
inoremap <space>tt <C-R>=strftime("%Y-%m-%d")<CR>

"{ Remappings

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
"{ Colorshemes and visual plugins
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
"""{ ALE (Asynchronous Lint Engine)
Plug 'w0rp/ale'
let g:ale_linters = {
\ 'sh': ['shellcheck'] ,
\ 'terraform': ['tflint'] ,
\ 'ansible': ['ansible'] ,
\ 'python': ['flake8'] ,
\ }
let g:ale_fixers = {
\   'sh': ['shfmt'],
\   'python': ['isort', 'yapf'],
\}

let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_sh_shfmt_options='-i 2'
" let g:ale_sh_shfmt_options='-i 2 -ci' " Google style

" key bindings
nmap <silent> <space>aj :ALENext<cr>
nmap <silent> <space>ak :ALEPrevious<cr>
nmap <silent> <space>af :ALEFix<cr>
" Autofix
" let g:ale_fix_on_save = 1
" }
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
"""{ Ansible
" https://github.com/pearofducks/ansible-vim
Plug 'pearofducks/ansible-vim'
let g:ansible_attribute_highlight = "ob"
let g:ansible_extra_keywords_highlight = 1
let g:ansible_normal_keywords_highlight = 'Constant'
let g:ansible_with_keywords_highlight = 'Constant'
" Detect a custom pattern
au BufRead,BufNewFile */ansible/*.yml set filetype=yaml.ansible
au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
"""}
"{ Terraform
Plug 'hashivim/vim-terraform'
let g:terraform_align=1
let g:terraform_fmt_on_save=1
let g:terraform_commentstring='# %s'
"} END of Terraform
"""{ Markdown
"https://github.com/plasticboy/vim-markdown
Plug 'plasticboy/vim-markdown'

let g:vim_markdown_fenced_languages = ['bash=sh', 'vim', 'conf', 'config', 'terraform', 'yaml']
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_conceal = 0
let g:vim_markdown_folding_style_pythonic = 1

" https://github.com/JamshedVesuna/vim-markdown-preview
Plug 'jamshedvesuna/vim-markdown-preview'

let vim_markdown_preview_hotkey='<C-m>'      " Mapping Control M
let vim_markdown_preview_browser='Google Chrome'
" GitHub flavoured markdown you need to install Python grip `pip install grip`
let vim_markdown_preview_github=1
let vim_markdown_preview_temp_file=1  " Remove the rendered preview file

Plug 'mzlogin/vim-markdown-toc'
" }

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
"
"
"
" vim: foldmethod=marker foldcolumn=4 foldenable
