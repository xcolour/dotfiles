"
" vundle
"

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'airblade/vim-gitgutter'
Bundle 'pangloss/vim-javascript'

"
" behavior
"

set nocompatible  " use vim, not vi settings
set wildmenu      " command line tab completion menu
set wildignore=*.pyc,.git " ignore from autocomplete
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set ignorecase    " ignore case in search
set smartcase     " respect case in search if uppercase is used
set nowrap        " do not wrap lines
set backspace=indent,eol,start " backspace over all stuff
set vb t_vb=      " no beeping
set laststatus=2  " always show the status line

"
" formatting
"

set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set shiftround
set listchars=tab:»·,trail:·
set list

"
" filetype-specific
"

if has("autocmd")
  filetype plugin indent on

  au!
  au FileType text                  setlocal tw=80 ts=2 sw=2 sts=2
  au FileType markdown              setlocal tw=80 ts=2 sw=2 sts=2
  au FileType html                  setlocal ts=2 sw=2 sts=2
  au FileType xhtml                 setlocal ts=2 sw=2 sts=2
  au FileType ruby                  setlocal ts=2 sw=2 sts=2
  au FileType eruby                 setlocal ts=2 sw=2 sts=2
  au FileType htmldjango            setlocal ts=2 sw=2 sts=2
  au FileType coffee                setlocal ts=2 sw=2 sts=2

  " text files
  au BufRead,BufNewFile *.txt       setlocal filetype=text

  " markdown
  au BufRead,BufNewFile *.md        setlocal filetype=markdown

  " html templates
  au BufRead,BufNewFile *.mako      setlocal filetype=html
  au BufRead,BufNewFile *.ftl       setlocal filetype=html
  au BufRead,BufNewFile *.handlebars setlocal filetype=html ts=4 sts=4 sw=4

  " css templates
  au BufRead,BufNewFile *.less      setlocal filetype=css

  " zsh configs and scripts
  au BufRead,BufNewFile *.zsh-overrides setlocal filetype=zsh
  au BufRead,BufNewFile *.zsh       setlocal filetype=zsh

  " ruby files
  au BufRead,BufNewFile *.cap       setlocal filetype=ruby

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif

"
" bindings
"

let mapleader = ","

" convenience
nnoremap <leader>x :source ~/.vimrc<Enter>
nnoremap <leader><leader> <c-^>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
"nnoremap <??> 10<c-e> 10j
"nnoremap <??> 10<c-y> 10k

" NERDTree
nnoremap <leader>e :NERDTreeToggle<Enter>
let NERDTreeMapActivateNode='<Space>'

" bufexplore
nnoremap <leader>fe :BufExplorer<Enter>
nnoremap <leader>fs :BufExplorerHorizontalSplit<Enter>
nnoremap <leader>fv :BufExplorerVerticalSplit<Enter>

" ctrlp
let g:ctrlp_map ='<leader>a'

" solarized
nnoremap <leader>vl :let g:solarized_visibility="low" | colo solarized<Enter>
nnoremap <leader>vh :let g:solarized_visibility="high" | colo solarized<Enter>

"
" visual
"

let g:solarized_visibility="high"  "trailing characters very visible
let g:solarized_menu=0             "don't show the gui menu
set synmaxcol=500
syntax on
set background=light
colo solarized
set hlsearch

" don't mess up gutter highlight with gitgutter
highlight clear SignColumn
hi! link SignColumn Background

"
" local additions
"

if filereadable($HOME."/.vimrc-local")
    source ~/.vimrc-local
endif
