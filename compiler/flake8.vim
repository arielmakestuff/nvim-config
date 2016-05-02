if exists('current_compiler')
   finish
endif
let g:current_compiler = 'flake8'
if exists(':CompilerSet') != 2
   command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet makeprg=($XDG_DATA_HOME/nvim/pyvenv3/bin/flake8\ --max-complexity\ 13\ %)
CompilerSet errorformat=%f:%l:%c:\ %m
