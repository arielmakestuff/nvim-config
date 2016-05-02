if g:colors_name =~# 'zenburn'
    highlight Visual cterm=bold ctermfg=233 ctermbg=109
                \ gui=bold guifg=#000d18 guibg=#8faf9f
elseif g:colors_name =~# 'OceanicNext'
    highlight LineNr ctermfg=145 ctermbg=239
                \ guifg=#a7adba guibg=#21272b
    highlight CursorLineNr ctermfg=145 ctermbg=239
                \ gui=bold guifg=#a7adba guibg=#21272b

    " Use IncSearch colours for MatchParen
    highlight MatchParen ctermfg=238 ctermbg=209
                \ guifg=#343d46 guibg=#f99157

    " Use Search colours for MatchParen
    " highlight MatchParen ctermfg=59 ctermbg=221
    "             \ guifg=#65737e guibg=#fac863

    " Use blue bg colour for MatchParen
    " highlight MatchParen ctermfg=59 ctermbg=68
    "             \ guifg=#65737e guibg=#6699cc
endif
