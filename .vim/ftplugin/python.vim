" Set a color column in column 80
set colorcolumn=80

" Update tags every time a python file is saved
autocmd BufWritePost *.py :TlistUpdate

" Don't autofold code
let g:pymode_folding = 1

" Do not show all the possibilities (this way is faster and it doesn't select
" the first option automatically)
let g:jedi#popup_on_dot = 0

