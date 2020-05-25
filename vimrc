set nocompatible

syntax enable
filetype plugin indent on
set encoding=utf-8
set backspace=indent,eol,start
set t_Co=256
set iskeyword+=-  " Treat dashes as part of word

set hidden        " Allow buffers to be hidden if modified

set mouse=a       " Automatically enable mouse usage
set mousehide     " Hide the mouse cursor while typing

" Display
set number        " Show line numbers
set showmatch     " Highlight matching brace
set modeline      " Read infile vim settings
set wildmenu      " Enhanced command-line completion
set autoread      " Automatically read a file changed outside of vim
set cursorline    " Highlight current line
set splitright    " Puts new vsplit windows to the right of the current
set splitbelow    " Puts new split windows to the bottom of the current
" set cmdheight=2   " Better display for messages

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

" Show hidden characters
set list
set listchars=tab:→\ ,eol:↵,trail:•,extends:↷,precedes:↶

set foldenable
set foldmethod=indent
set foldlevelstart=20
set foldmarker={,}
set foldcolumn=0

" Unnamed clipboard
if has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  set clipboard+=unnamed
endif


" Set browser in WSL
if filereadable("/mnt/c/Windows/System32/clip.exe")
  let g:netrw_browsex_viewer="cmd.exe /C start"
endif

" WSL vim to windows clipboard
if filereadable("/mnt/c/Windows/System32/clip.exe")
  let s:clip = '/mnt/c/Windows/System32/clip.exe'
  if executable(s:clip)
    augroup WSLYank
    autocmd!
    autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
    augroup END
  end
endif

" Ensure junegunn/vim-plug is installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Functionality plugins
Plug 'freitass/todo.txt-vim'
highlight  default  link  TodoPriorityA  Constant
highlight  default  link  TodoPriorityB  Title
highlight  default  link  TodoPriorityC  String
highlight  default  link  TodoPriorityR  Bold
highlight  default  link  TodoProject    Statement
highlight  default  link  TodoContext    Structure

Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'              " http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround' " Provides mappings to delete, change and add surroundings in pairs.

Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <space>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <leader>      :<c-u>WhichKey '\'<CR>

" Issue https://github.com/chriskempson/base16-vim/issues/197
" Pull Request https://github.com/chriskempson/base16-vim/pull/198
Plug 'danielwe/base16-vim'
Plug 'yggdroot/indentline'

" Status and tabline for vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#coc#enabled = 1

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
let NERDTreeSortOrder = ['\/$','[[-timestamp]]']
map <space>ft :NERDTreeToggle<CR>

" Plug 'ervandew/supertab'
" let g:SuperTabDefaultCompletionType = "<c-n>"
"
" Coc autocompletion
" curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-dictionary',
\ 'coc-ultisnips',
\ ]

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_command_prefix = 'Fz' " Same prefix to all commands
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" Commands
nnoremap <space>ff :FzFiles<CR>
nnoremap <space>bB :FzBuffers<CR>
nnoremap <space>bW :FzWindows<CR>
nnoremap <space>fzf :FzFiles<CR>
nnoremap <space>fzg :FzGFiles?<CR>
nnoremap <space>fa :FzAg<CR>
nnoremap <space>fa* :FzAg <C-R><C-W><CR>:cw<CR>
nnoremap <space>fzl :FzLines<CR>
nnoremap <space>fzbl :FzBLines<CR>
nnoremap <space>fzt :FzTags<CR>
nnoremap <space>fzbt :FzBTags<CR>
nnoremap <space>fzm :FzMarks<CR>
nnoremap <space>fzw :FzWindows<CR>
nnoremap <space>fzco :FzCommits<CR>
nnoremap <space>fzcmd :FzCommands<CR>

" Mapping selecting mappings
nmap <space>? <plug>(fzf-maps-n)
imap <space>? <plug>(fzf-maps-i)
xmap <space>? <plug>(fzf-maps-x)
omap <space>? <plug>(fzf-maps-o)
" Insert mode completion
imap <space><tab>k <plug>(fzf-complete-word)
imap <space><tab>f <plug>(fzf-complete-path)
imap <space><tab>j <plug>(fzf-complete-file-ag)
imap <space><tab>l <plug>(fzf-complete-line)
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

let g:vim_markdown_fenced_languages = [
\ 'sh',
\ 'bash=sh',
\ 'shell=sh',
\ 'vim',
\ 'conf',
\ 'config',
\ 'terraform',
\ 'yaml',
\ ]

let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0 " TODO: Temp fix for https://github.com/plasticboy/vim-markdown/issues/408
let g:vim_markdown_folding_level = 3
let g:vim_markdown_folding_style_pythonic = 1

" Deletegate bullets to another plugin
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

Plug 'dkarter/bullets.vim'
let g:bullets_enabled_file_types = [
\ 'markdown',
\ 'text',
\ 'gitcommit',
\ 'scratch'
\ ]

Plug 'jkramer/vim-checkbox'
let g:insert_checkbox = '\<'
let g:insert_checkbox_prefix = '- '

" TODO: revisit this plugin to see if it is good form vim.
" As of now (2019-10-20) the normal mode mapping do not work
" Plug 'SidOfc/mkdx'
" let g:markdown_fenced_languages = ['sh', 'bash=sh', 'shell=sh', 'vim', 'conf', 'config', 'terraform', 'yaml']
" let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
"                         \ 'enter': { 'shift': 1 },
"                         \ 'links': { 'external': { 'enable': 1 } },
"                         \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
"                         \ 'map':                     { 'prefix': '<leader>', 'enable': 1  },
"                         \ 'fold': { 'enable': 1 } }
" let g:polyglot_disabled = ['markdown'] " for vim-polyglot users, it loads Plasticboy's markdown
"                                        " plugin which unfortunately interferes with mkdx list indentation.

Plug 'mzlogin/vim-markdown-toc'
let g:vmt_list_item_char = '-'
let g:vmt_fence_text = 'TOC'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

Plug 'hashivim/vim-terraform'
let g:terraform_align=1
let g:terraform_fold_sections=1
"let g:terraform_fmt_on_save=1 # Disabled because of misformats tfvars files
let g:terraform_commentstring='# %s'

Plug 'dense-analysis/ale'
let g:ale_linters = {
\ 'sh': ['shellcheck'] ,
\ 'md': ['markdownlint'],
\ 'terraform': ['tflint'] ,
\ 'ansible': ['ansible'] ,
\ 'python': ['flake8'] ,
\ }
let g:ale_fixers = {
\   'sh': ['shfmt'],
\   'python': ['isort', 'yapf'],
\ }

let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_sh_shfmt_options='-i 2 -ci' " Google style
let g:ale_set_highlights=0
" key bindings
nmap <silent> <space>aj :ALENext<cr>
nmap <silent> <space>ak :ALEPrevious<cr>
nmap <silent> <space>af :ALEFix<cr>
" Autofix
" let g:ale_fix_on_save = 1
" }
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

call plug#end()

" Load base16 shell theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

"" Show text rulers - Highlight column 80, 100 as well as 120 and onward
"" http://stackoverflow.com/questions/2447109/showing-a-different-background-colour-in-vim-past-80-characters
let &colorcolumn="80,100,".join(range(120,999),",")

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
nmap <space>bb :b#<CR>
" Show all open buffers and their status
nmap <space>bl :ls<CR>
" Edit vimrc
nnoremap <space>fed :vsplit $MYVIMRC<cr>
" Source vimrc
nnoremap <space>fds :source $MYVIMRC<cr>
" Open my GTD files
nnoremap <space>fet :sp $HOME/drive/notes/todo-txt/todo.txt<cr>
" Insert current date with week day
nnoremap <space>tT "=strftime("%a %Y-%m-%d")<CR>P
inoremap <space>tT <C-R>=strftime("%a %Y-%m-%d")<CR>
" Insert current date without week day
nnoremap <space>tt "=strftime("%Y-%m-%d")<CR>P
inoremap <space>tt <C-R>=strftime("%Y-%m-%d")<CR>
