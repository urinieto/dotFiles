" Oriol's titanic vim config file

" Enable syntax highlighting
syntax enable

" Really cool colorscheme
colorscheme codeschool
set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Display line numbers on the left
set number

" Use mouse (only for resizing uri!)
set mouse=a

" Reload vim whenever .vimrc is updated
autocmd! bufwritepost .vimrc source %

" Set the focus to the right screen (ok, no more mouse thingies)
set mousefocus

" Indent properly based on the current file
filetype indent plugin on

" Pathogen pluggin manager
execute pathogen#infect()

" Set path to exuberant ctags
let Tlist_Ctags_Cmd='/usr/bin/ctags-exu'

" Omnicompletion on
set omnifunc=syntaxcomplete#Complete

" Set a color column in column 80
set colorcolumn=80

" Open the Tag List by default
autocmd VimEnter * TlistOpen
autocmd VimEnter * wincmd p

" Remove scroll bar of the gui
set guioptions-=r
set guioptions-=L

" Change default fontsize to fit MacBook Pro 13'
set guifont=Menlo:h10

" Don't select first Omni-completion option
set completeopt=longest,menuone

" Update tags every time a python file is saved
autocmd BufWritePost *.py :TlistUpdate

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

" Allows multiple buffers opened at a given time
set hidden

set history=1000         " remember more commands and search history
set undolevels=1000      " use many levels of undo

" Tabs in command line mode behave like bash
set wildmode=list,full

" Highlight the entire word when searching for it
set hlsearch

"nnoremap <silent> n   n:call HLNext(0.2)<cr>
"nnoremap <silent> N   N:call HLNext(0.2)<cr>
"
"" Highlight the match in red
"function! HLNext (blinktime)
"    highlight WhiteOnRed ctermfg=white ctermbg=red
"    let [bufnum, lnum, col, off] = getpos('.')
"    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"    let target_pat = '\c\%#'.@/
"    let ring = matchadd('WhiteOnRed', target_pat, 101)
"    redraw
"    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"    call matchdelete(ring)
"    redraw
"endfunction

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list
