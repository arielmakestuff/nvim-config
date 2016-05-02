if exists('current_compiler')
   finish
endif
let g:current_compiler = 'vint'
if exists(':CompilerSet') != 2
   command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet makeprg=($XDG_DATA_HOME/nvim/pyvenv3/bin/vint\ %)
CompilerSet errorformat=%f:%l:%c:\ %m
