"
" behavior
"

set nocompatible  " use vim, not vi settings
set wildmenu      " command line tab completion menu
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set ignorecase    " ignore case in search
set smartcase     " respect case in search if uppercase is used
set nowrap        " do not wrap lines
set backspace=indent,eol,start " backspace over all stuff
set cursorcolumn  " highlight the current column

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
  au FileType text                  setlocal tw=72 ts=2 sw=2 sts=2
  au FileType html                  setlocal ts=2 sw=2 sts=2
  au FileType xhtml                 setlocal ts=2 sw=2 sts=2
  au FileType ruby                  setlocal ts=2 sw=2 sts=2
  au FileType eruby                 setlocal ts=2 sw=2 sts=2
  au FileType htmldjango            setlocal ts=2 sw=2 sts=2

  " text files
  au BufRead,BufNewFile *.txt       setlocal filetype=text

  " php files
  au BufRead,BufNewFile *.module    setlocal filetype=php
  au BufRead,BufNewFile *.inc       setlocal filetype=php
  au BufRead,BufNewFile *.install   setlocal filetype=php

  " html templates
  au BufRead,BufNewFile *.mako      setlocal filetype=html
  au BufRead,BufNewFile *.ftl       setlocal filetype=html

  " css templates
  au BufRead,BufNewFile *.less      setlocal filetype=css

  " zsh configs and scripts
  au BufRead,BufNewFile *.zsh-theme setlocal filetype=zsh
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

noremap <C-x> :source ~/.vimrc<Enter>
noremap <C-a> :call RunSpec()<Enter>

" NERDTree
noremap <C-e> :NERDTreeToggle<Enter>
noremap ,e :NERDTreeToggle<Enter>
let NERDTreeMapActivateNode='<Space>'

" bufexplore
noremap ,fe :BufExplorer<Enter>
noremap ,fs :BufExplorerHorizontalSplit<Enter>
noremap ,fv :BufExplorerVerticalSplit<Enter>

"
" visual
"

set background=light
if !has('gui_running')
    let g:solarized_termcolors=16
endif
colo solarized
syntax on
set hlsearch

"
" plugins
"

helptags $HOME/.vim/doc      " load all plugin docs

"
" local additions
"

if filereadable($HOME."/.vimrc-local")
    source ~/.vimrc-local
endif
