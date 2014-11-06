" After playing with this for a while, jedi-vim seems the only thing that is
" really needed for a nice python development enviromnent in vim.
" I deactivate YouCmpleteMe and python-mode in this script.

" Set a color column in column 80
set colorcolumn=80

" Update tags every time a python file is saved
"autocmd BufWritePost *.py :TlistUpdate

" Don't autofold code
"let g:pymode_folding = 1

" Do not show all the possibilities (this way is faster and it doesn't select
" the first option automatically)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_autoimport = 0
"let g:pymode_lint_ignore = "E265,E128,E251,E221,E203,E116,E266"

" You Complete Me Disabled!
let g:ycm_filetype_specific_completion_to_disable = {'python': 1}
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
let g:ycm_auto_trigger = 0
let g:ycm_key_invoke_completion = '<C-Q>' " Instead of <C-Space>
set runtimepath-=~/.vim/bundle/YouCompleteMe

" Use Jedi for autocompletion
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 1
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 1
let g:jedi#popup_on_dot = 1
let g:jedi#completions_command = "<C-Space>"

"if g:jedi#popup_on_dot
    "if g:jedi#popup_select_first
        "inoremap <silent> <buffer> . .<C-R>=jedi#do_popup_on_dot() ? "\<lt>C-X>\<lt>C-O>\<lt>C-N>" : ""<CR>
    "else
        "inoremap <silent> <buffer> . .<C-R>=jedi#do_popup_on_dot() ? "\<lt>C-X>\<lt>C-O>\<lt>C-P>" : ""<CR>
    "end
"end


" Run ptyhon codes
let g:pymode_run = 0
let g:pymode_run_bind = '<leader>r'

" Python-mode
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
"au BufWriteCmd *.py write || :PymodeLint " This fixes the pylint bug

"" Documentation
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'

""Linting
let g:pymode_lint = 0
"let g:pymode_lint_checker = "pyflakes,pep8"
"" Auto check on save
"let g:pymode_lint_write = 1

"" Support virtualenv
let g:pymode_virtualenv = 0

"" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

"" syntax highlighting
let g:pymode_syntax = 0
let g:pymode_syntax_all = 0
"let g:pymode_syntax_indent_errors = g:pymode_syntax_all
"let g:pymode_syntax_space_errors = g:pymode_syntax_all
"let g:pymode_lint_ignore = "E221,E128,C901,W0404,E702,E203"
