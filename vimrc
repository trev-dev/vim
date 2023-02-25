vim9script

import "./functions.vim"

# Look and Feel
syntax on
set t_Co=256
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set listchars=tab:>·,trail:~

set list

# Indentation
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

# Editor
set incsearch

# Bindings
g:mapleader = " "

nmap <leader>tw :call ToggleList()<CR>
