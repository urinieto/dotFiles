" Oriol's vim config file for OSX
set nocompatible              " enter the current century
filetype off                  " required for vundle

" Vundle stuff
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'Shougo/neocomplete.vim'
Plugin 'davidhalter/jedi-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Enables highlight syntax
syntax enable
set nofoldenable

" Sweet colorscheme
set background=dark
let g:solarized_termcolors = 256  " New line!!
colorscheme solarized

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8

"" Display line numbers on the left
set number

"" Use mouse (only for resizing uri!)
set mouse=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

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

" Let vim know that cls files are LaTeX classes
au BufNewFile,BufRead *.cls set filetype=tex
au BufNewFile,BufRead *.tex set filetype=tex

" set text file type
au BufRead,BufNewFile *.txt setfiletype text

" set XML file type
au BufRead,BufNewFile *.wwu setfiletype xml

" set Objective-C file type
au BufRead,BufNewFile *.mm setfiletype c

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

" Control P plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

" Change cursor
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Vim-airline stuff
set laststatus=2 " Always show statusline
let g:airline_powerline_fonts=1
let g:airline_theme='durant'

" Syntastic stuff
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore=E116,E114'
let g:syntastic_loc_list_height = 3

" YouCompleteMe
"let g:ycm_python_binary_path = '/Users/uri/anaconda3/bin/python'
"let g:ycm_python_binary_path = '/Users/uri/anaconda/bin/python'
"let g:ycm_python_binary_path = 'python'
"let g:ycm_key_invoke_completion = '<C-b>'
"let g:ycm_server_keep_logfiles = 1

" Neocomplete
"let g:acp_enableAtStartup = 0
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"let g:neocomplete#data_directory = '~/.vim/tmp/neocomplete'
"" Enable omni completion.
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
