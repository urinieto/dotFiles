" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" Activate spellchecker
set spell spelllang=en_us

" Fuck folding
au BufRead * normal zR
au BufWinEnter * normal zR

" Do not add the weird jumping syntax
let g:Imap_UsePlaceHolders = 0

" Compile every time I save
"au BufWritePost *.tex :make %
"au BufWritePost *.tex :'.
"au BufWritePost *.tex :!open /Applications/Preview.app/

" Remove guide column
set colorcolumn=0

" For some reason this line makes the compilation of bibtex work
let g:Tex_MultipleCompileFormats='dvi,pdf'
let g:Tex_CompileRule_pdf = 'pdflatex --synctex=-1 -src-specials -interaction=nonstopmode -file-line-error-style $*'

set wrap
set textwidth=0

" Do not jump to error/warnings when compiling (but populate the quickfix list)
let g:Tex_GotoError=0

" Do not fold too much
let g:Tex_FoldedSections="part,chapter,section"
let g:Tex_FoldedSections=''
let g:Tex_FoldedEnvironments=''
let g:Tex_Folding=0
let Tex_FoldedSections=''
let Tex_FoldedEnvironments=''
let Tex_FoldedMisc=''

