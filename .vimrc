" Oriol's titanic vim config file
" Enables highlight syntax
syntax enable
set nofoldenable

" Sweet colorscheme
colorscheme codeschool
set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8

"" Display line numbers on the left
set number

"" Use mouse (only for resizing uri!)
set mouse=a

" Set the focus to the correct screen (ok, no more mouse thingies)
set mousefocus

" No more annoying sounds
set visualbell

" Do not scroll sideways unless we reach the end of the screen
set sidescrolloff=0

" highlight the status bar when in insert mode
if version >= 700
    if has("gui_running")
        au InsertEnter * hi StatusLine guifg=black guibg=green
        au InsertLeave * hi StatusLine guibg=black guifg=grey
    else
        au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
        au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12
    endif
endif

" Infere the case-sensitivity
set infercase

" Need to set this flag on in order to have many cool features on
set nocompatible

" Indent properly based on the current file
filetype indent plugin on
filetype plugin on

" Let vim know that cls files are LaTeX classes
au BufNewFile,BufRead *.cls set filetype=tex
au BufNewFile,BufRead *.tex set filetype=tex

" set text file type
au BufRead,BufNewFile *.txt setfiletype text

" set Objective-C file type
au BufRead,BufNewFile *.mm setfiletype c

" Pathogen load
"filetype off " Makes syntax non-working on office box
call pathogen#infect()
call pathogen#helptags()

" Set path to exuberant ctags
"let Tlist_Ctags_Cmd='/usr/bin/ctags-exu'

" Omnicompletion on
"set omnifunc=syntaxcomplete#Complete

" Open the Tag List by default
"autocmd VimEnter * TlistOpen
"autocmd VimEnter * wincmd p

" Switch between files in buffer
nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>

" Remove scroll bar of the gui
set guioptions-=r
set guioptions-=L

" Change default fontsize to fit MacBook Pro 13'
set guifont=Monaco:h11

" Don't select first Omni-completion option
set completeopt=preview,menuone
"set completeopt=longest,menuone
"set completeopt=menuone,longest,preview

set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set incsearch     " show search matches as you type
set expandtab
set shiftwidth=4
set softtabstop=4

" Always set the current file directory as the local current directory
autocmd BufEnter * silent! lcd %:p:h

" Enable folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Save foldings
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

" No folding when opening a file (99 = no closed folds)
"set foldlevelstart=99

set history=1000         " remember more commands and search history
set undolevels=1000      " use many levels of undo

" Tabs in command line mode behave like bash
set wildmode=longest,list,full
set wildmenu

" Highlight the entire word when searching for it
set hlsearch

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" Move line by line even when the line is wrapped
map j gj
map k gk

" Persistent undo
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" YouCompleteMe
"let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py"
"nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
"let g:ycm_custom_enable = 1

" Setup Clang Library
let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
if isdirectory(s:clang_library_path)
    let g:clang_library_path=s:clang_library_path
endif

let g:clang_use_library=1
let g:clang_auto_select=0 "select first entry in popup menu but don't insert in code
let g:clang_complete_auto=1 "auto complete after -> . and ::
let g:clang_complete_copen=0 "open quick fix on error
let g:clang_complete_hl_errors=1 " highlight errors and warnings
let g:clang_periodic_quickfix=1 " update quickfix periodically
let g:clang_trailing_placeholder=1 " add trailing placeholder after function
let g:clang_close_preview=1 " close preview window after completion
let g:clang_snippets=1 " some magic after function ( or ,
let g:clang_debug=0
