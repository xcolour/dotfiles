"
" register pathogen
"

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

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
set cursorcolumn  " highlight the current column
set cursorline    " highlight the current line
set vb t_vb=      " no beeping

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

" NERDTree
nnoremap <C-e> :NERDTreeToggle<Enter>
nnoremap <leader>e :NERDTreeToggle<Enter>
let NERDTreeMapActivateNode='<Space>'

" bufexplore
nnoremap <leader>fe :BufExplorer<Enter>
nnoremap <leader>fs :BufExplorerHorizontalSplit<Enter>
nnoremap <leader>fv :BufExplorerVerticalSplit<Enter>

" ctrlp
let g:ctrlp_map ='<leader>a'

"
" visual
"

let g:solarized_visibility="high"  "trailing characters very visible
let g:solarized_menu=0             "don't show the gui menu
syntax on
set background=light
colo solarized
set hlsearch

"
" local additions
"

if filereadable($HOME."/.vimrc-local")
    source ~/.vimrc-local
endif
