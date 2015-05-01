call pathogen#infect()
runtime macros/matchit.vim
"set termencoding=latin1
:Helptags
":!ctags -R r
filetype on 
filetype plugin indent on
filetype plugin on

set encoding=utf-8
set wrapscan

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
    "set background=dark
endif

if $COLORTERM == 'rxvt-xpm'
    set t_Co=256
    "set background=dark
endif

"set background=dark
" Set syntax if terminal supports colors
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    set t_Co=256
    syntax on
endif

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=79

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

augroup Cpp
    au BufNewFile *.cpp 0r ~/pro/skeletons/skeleton.cpp
augroup end

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Display extra whitespace
set fillchars+=stl:\ ,stlnc:\
set list listchars=tab:▸\ ,trail:·,eol:¬         " Invisibles using the Textmate style
set mps+=<:>

set autochdir

set autowrite

colorscheme gruvbox
"colorscheme github 

set tabstop=4
set backspace=2
set shiftwidth=2
set softtabstop=2
set expandtab


set showmatch
set smartcase
set smarttab
set showcmd
set incsearch
set hlsearch

set confirm
set pastetoggle=<F2>
set number
set laststatus=2
set norelativenumber

set timeoutlen=400
set autoread

set novisualbell
set visualbell t_vb=
set ruler

set cindent
set t_RV=

if exists("+spelllang")
  set spelllang=en_us
endif
set spellfile=~/.vim/spell/en.utf-8.add
"
" Map ctrl-movement keys to window switching
"map <C-k> <C-w><k>
"map <C-j> <C-w><j>
"map <C-l> <C-w><l>
"map <C-h> <C-w><h>
"
"CTRL-W <Down>					*CTRL-W_<Down>*
"CTRL-W CTRL-J					*CTRL-W_CTRL-J* *CTRL-W_j*
"CTRL-W j	Move cursor to Nth window below current one.  Uses the cursor
"		position to select between alternatives.

"CTRL-W <Up>					*CTRL-W_<Up>*
"CTRL-W CTRL-K					*CTRL-W_CTRL-K* *CTRL-W_k*
"CTRL-W k	Move cursor to Nth window above current one.  Uses the cursor
"		position to select between alternatives.
"
"nnoremap <tab> <C-w>
"nnoremap <tab><tab> <C-w><C-w>
nnoremap <silent> <A-h> <C-w><
nnoremap <silent> <A-k> <C-W>-
nnoremap <silent> <A-j> <C-W>+
nnoremap <silent> <A-l> <C-w>>
function! Altmap(char)
  if has('gui_running') | return ' <A-'.a:char.'> ' | else | return ' <Esc>'.a:char.' '|endif
endfunction
if $TERM == 'rxvt-unicode-256color'&&!has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    autocmd InsertEnter * set timeoutlen=400
    autocmd InsertLeave * set timeoutlen=2000
  augroup END
  execute 'nnoremap <silent>'.Altmap('h').'<C-w><'
  execute 'nnoremap <silent>'.Altmap('k').'<C-w>-'
  execute 'nnoremap <silent>'.Altmap('j').'<C-w>+'
  execute 'nnoremap <silent>'.Altmap('l').'<C-w>>'
endif
set wrap
if has('statusline')
  set laststatus=2
  " Broken down into easily includeable segments
  set statusline=%<%f\    " Filename
  set statusline+=%w%h%m%r " Options
  set statusline+=%{fugitive#statusline()} "  Git Hotness
  set statusline+=\ [%{&ff}/%Y]            " filetype
  set statusline+=\ [%{getcwd()}]          " current dir
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_enable_signs=1
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set foldmethod=indent
set foldlevel=99
au VimResized * :wincmd =

au FocusLost * :wa
let mapleader=','
set title
"set cursorcolumn
"set cursorline
"

"nnoremap <C-t> :tabnew<Space>
nnoremap <F5> :TlistToggle<CR>
"inoremap <C-t> <Esc>:tabnew<Space>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"buffer navigation

nnoremap <S-h> :bprevious<CR>
nnoremap <S-l> :bnext<CR>

set lazyredraw
" set confirm
set viminfo='20,\"500
set hidden
set history=50
"set clipboard=unnamedplus

" Instead of these two options, we can set a single directory for all backups
" and temporary buffers. This is a better solution in case we don't want our
" current buffer to be destroyed due to any IOError.
"
" set backupdir=~/.vimtmp
" set directory=~/.vimtmp
set nobackup
set nowritebackup " Writes the buffer to the same file
set noswapfile

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Do not leave visual mode after visually shifting text
vnoremap < <gv
vnoremap > >gv

set wildchar=<Tab> wildmenu wildmode=full
set complete=.,w,t

"set wildmenu
"set wildmode=list:longest
set wildignore+=.hg,.git,.svn " Version Controls"
set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.spl "Compiled speolling world list"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.DS_Store "OSX SHIT"
set wildignore+=*.luac "Lua byte code"
set wildignore+=migrations "Django migrations"
set wildignore+=*.pyc "Python Object codes"
set wildignore+=*.orig "Merge resolution files"

"let g:nerdtree_tabs_autofind=1
let g:nerdtree_tabs_synchronize_view=0
"let g:nerdtree_tabs_synchronize_focus=0
" Set it to 0 if your tags are on a network directory
let g:ycm_collect_identifiers_from_tags_files = 1

nnoremap <F9> :NERDTreeToggle<cr>
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let g:ctrlp_map = '<c-p>'

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

" Fixes issue with strange character appearing in place of space
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
set tags=./tags;/

" To close the error window when using :bdelete command
" ( For syntastic plugin )
nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
cabbrev <silent> bd lclose\|bdelete
let g:syntastic_auto_loc_list=1 "Update location list


" Theme
let g:molokai_original = 1
let g:rehas256 = 1

"NerdTree position
let g:NERDTreeWinPos = "right"

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf = 0
let g:ycm_goto_buffer_command='vertical-split'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" Settings for Vim-notes
let g:notes_directories = ['~/my_coding/Notes']
let g:notes_title_sync = 'rename_file'

" Settings for UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/bundle/vim-snippets/UltiSnips"

let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

hi MatchParen cterm=none ctermbg=none ctermfg=red
hi MatchParen gui=NONE guibg=NONE guifg=red
hi Normal ctermbg=none
"hi Cursor gui=NONE guifg=#190707 guibg=#11BA0B
nnoremap <Leader>f :NERDTreeTabsToggle<CR>

map ; :
inoremap jk <Esc>
inoremap <Left>  <NOP> 
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP> 
noremap <F4> :set hlsearch! hlsearch?<CR>
noremap <F3> :let @+=@"<CR>
"Paste in new line
map <Leader>P o<Esc>p
"Paste from system clipboard
map <Leader>p "+p
"Copy to system clipboard
vnoremap <Leader>y :<C-u>let @+=@*<CR>
nnoremap <Leader>yy :<C-u>let @+=getline('.')."\n"<CR>
"Don't let deletions go into clipboard
nnoremap <Leader>d "_d
nnoremap <Leader>D "_D
nnoremap <Leader>C "_C
nnoremap <Leader>c "_c
nnoremap <Leader>x "_x
vnoremap <Leader>d "_d
vnoremap <Leader>D "_D
vnoremap <Leader>C "_C
vnoremap <Leader>c "_c
vnoremap <Leader>x "_x


nnoremap <silent> n n:call HLNext(0.1)<cr>
nnoremap <silent> N N:call HLNext(0.1)<cr>

function! HLNext (blinktime)
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction
