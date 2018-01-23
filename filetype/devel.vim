set nobackup
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent

set nowrap
set textwidth=80
set wrapmargin=0
set foldcolumn=0

set nospell

" ------------------------------
" Set underline for current line
" ------------------------------
hi clear CursorLine
hi CursorLine gui=underline cterm=underline ctermfg=None guifg=None
set cursorline
