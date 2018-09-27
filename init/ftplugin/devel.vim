setlocal nobackup
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal smarttab
setlocal autoindent

setlocal nowrap
setlocal textwidth=80
setlocal wrapmargin=0
setlocal foldcolumn=0

setlocal nospell

setlocal colorcolumn=80

" ------------------------------
" Set underline for current line
" ------------------------------
" Disable this only on windows since this doesn't work properly with nvim-qt
if !g:has_windows
    hi clear CursorLine
    hi CursorLine gui=underline cterm=underline ctermfg=None guifg=None
    setlocal cursorline
endif
