let mapleader=','

" Do not leave visual mode after visually shifting text
vnoremap < <gv
vnoremap > >gv


" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %


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
