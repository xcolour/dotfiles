" .vimrc

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

"
" formatting
"

set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set listchars=tab:»·,trail:·
set list

"
" filetype-specific
"

if has("autocmd")
  filetype plugin indent on

  au!
  au FileType text setlocal textwidth=72
  au FileType html setlocal ts=2 sw=2 sts=2 expandtab
  au FileType ruby setlocal ts=2 sw=2 sts=2 expandtab

  " text files
  au BufRead,BufNewFile *.txt      setlocal filetype=text

  " php files
  au BufRead,BufNewFile *.module    setlocal filetype=php
  au BufRead,BufNewFile *.inc       setlocal filetype=php
  au BufRead,BufNewFile *.install   setlocal filetype=php

  " html templates
  au BufRead,BufNewFile *.mako      setlocal filetype=html
  au BufRead,BufNewFile *.ftl      setlocal filetype=html

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif

"
" visual
"

color fruit
syntax on
set hlsearch
