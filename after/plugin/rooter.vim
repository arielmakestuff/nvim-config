if !exists('g:loaded_rooter')
  finish
endif

" Setup denite file rec keybinding
let s:rooter_root_dir = FindRootDirectory()
if g:has_windows
    let s:rooter_root_dir = substitute(s:rooter_root_dir, '\', '/', 'g')
endif

let s:denite_filerec_exec = 'nnoremap ' . g:denite_filerec_bind . ' '
            \ . g:denite_filerec_cmd

if s:rooter_root_dir != ''
    let s:denite_filerec_exec = s:denite_filerec_exec
                \ . ' -path='
                \ . s:rooter_root_dir
endif

if g:has_windows
    let s:carriage_return = ''
else
    let s:carriage_return = '<CR>'
endif
let s:denite_filerec_exec = s:denite_filerec_exec
            \ . s:carriage_return

exec s:denite_filerec_exec
