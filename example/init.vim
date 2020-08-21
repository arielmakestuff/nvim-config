
augroup terminal_buffer
    autocmd!
    autocmd TermOpen *
                \ setlocal listchars= nonumber norelativenumber |
                \ startinsert
    autocmd BufEnter,BufWinEnter,WinEnter term://*
                \ setlocal listchars= nonumber norelativenumber |
                \ startinsert
    autocmd BufLeave term://* stopinsert
augroup END

