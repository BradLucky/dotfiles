" silence plugin errors with Python 3 (imp deprecation)
if has('python3')
    silent! python3 1
endif

" **************************
" *** Begin Vundle setup ***
" **************************

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle
Plugin 'Valloric/YouCompleteMe', {'do': './install.py --tern-completer' }
"Plugin 'mxw/vim-jsx'                    " JSX support
Plugin 'pangloss/vim-javascript'        " better syntax and indenting for JS
"Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'flazz/vim-colorschemes'
"Plugin 'vim-syntastic/syntastic'
Plugin 'w0rp/ale'                       " asynchronous linting engine
Plugin 'sheerun/vim-polyglot'
Plugin 'scrooloose/nerdtree'            " tree view for vim
Plugin 'Xuyuanp/nerdtree-git-plugin'    " git status for NERDTree
Plugin 'vim-airline/vim-airline'        " a useful statusbar
Plugin 'tpope/vim-fugitive'             " Git wrapper

" All of your Plugins must be added before the following line
call vundle#end()

" ************************
" *** End Vundle setup ***
" ************************

" Activate auto filetype detection
filetype plugin indent on
syntax enable

silent! colorscheme molokai
"hi Visual ctermbg=239

" Added for vim-jsx (that seemed to be breaking indenting)
"let g:javascript_plugin_flow = 1 " JavaScript Flow
"let g:jsx_ext_required = 0 " support other extensions
"let g:vim_jsx_pretty_enable_jsx_highlight = 0 " default 1
"let g:vim_jsx_pretty_colorful_config = 1 " default 0

" Check Python files with flake8 and pylint.
"let b:ale_linters = ['flake8', 'pylint', 'pycodestyle', 'pydocstyle']
let b:ale_linters = ['pylint', 'flake8']
let g:ale_python_pylint_change_directory = 0

" Syntastic settings
"let g:syntastic_check_on_wq = 0 " don't check syntax on wq

set tags=./tags,tags,~/tags

" Instantly jump to the definition of any class or method
"*set tags+=$SB/src/applib/tags

set incsearch                   " Search as you type
set showcmd                     " Command displays as you type
set ignorecase                  " Don't care about case...
set smartcase                   " ... unless the query contains upper case characters
set autoindent                  " Enable automatic indenting for files with ft set
set nowrap                      " No fake carriage returns
set showcmd                     " Show command in statusline as it's being typed
set showmatch                   " Jump to matching bracket
set ruler                       " Show row,col %progress through file
set laststatus=2                " Always show filename (2 is always)
set hidden                      " Let us move between buffers without writing them.  Don't :q! or :qa! frivolously!
set softtabstop=4               " Vim sees 4 spaces as a tab
set shiftwidth=4                " < and > uses spaces
set expandtab                   " Tabs mutate into spaces
set splitright                  " New vertical splits open on the right
set splitbelow                  " New horizontal splits open on the bottom
set backspace=indent,eol,start  " Make backspace work like other editors.
set hlsearch                    " Highlight all search matches
set clipboard=unnamed           " (y)ank puts into system clipboard, (p)ut pastes from system clipboard
set number
set mouse=a                     " Enable mouse in all modes
set nostartofline               " Don’t reset cursor to start of line when moving around.
set title                       " Show the filename in the window titlebar
" set tabstop=4                   " 4-space indents
" set smarttab                    " <TAB> width determined by shiftwidth instead of tabstop.  
" set foldmethod=indent           " Default folding

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>

" Turn off highlighting easily by pressing <SPACE> when done searching
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

autocmd BufNewFile,BufRead /*apache* setfiletype apache
autocmd BufNewFile,BufRead /*lighttpd*.conf setfiletype lighty
autocmd BufNewFile,BufRead *.pd setfiletype html
autocmd BufNewFile,BufRead Jenkinsfile setfiletype groovy
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

" remove trailing whitespace from source code
autocmd BufWritePre *.{py,pd,js,jsx,html,rb,c,cpp,markdown,md,rst,java,php,cfg,css} :%s/\s\+$//e

" Nicer highlighting of completion popup
highlight Pmenu guibg=brown gui=bold

" Highlight lines over 77 columns (warning) and 81 columns (error) in *.py files only
if has('matchadd')
    :au BufWinEnter *.py let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
    :au BufWinEnter *.py let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
else
    :au BufRead,BufNewFile *.py syntax match Search /\%<81v.\%>77v/
    :au BufRead,BufNewFile *.py syntax match ErrorMsg /\%>80v.\+/
endif

if &diff
    colorscheme evening
endif

" 3-column Git conflict management with Fugitive: https://dev.to/prodopsio/solving-git-merge-conflicts-with-vim-5275
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

if filereadable($HOME."/.local/vim/.vimrc")
    source $HOME/.local/vim/.vimrc
endif
