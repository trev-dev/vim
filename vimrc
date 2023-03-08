vim9script

g:mapleader = " "

set nocompatible
syntax on

# Editor Settings
set t_Co=256
set incsearch
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set listchars=tab:>·,trail:~
set list
set relativenumber
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set wildmenu
set wildoptions=fuzzy
set updatetime=300
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set hlsearch
set hidden
set colorcolumn=80

# Escape fixes for Kitty
&t_RV = ""
&t_ut = ""

# Change the cursor for insert/replace mode
# only works in VTE compatible terminals
&t_SI = "\<Esc>[6 q" # Insert
&t_SR = "\<Esc>[4 q" # Replace
&t_EI = "\<Esc>[2 q" # Normal

# Functions
def g:ToggleList()
  const fullChars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣"
  const trailingChars = "tab:>·,trail:~"
  if (&listchars == fullChars)
    &listchars = trailingChars
  else
    &listchars = fullChars
  endif
enddef

# Editor Keybinds
nmap <leader>tw :call ToggleList()<CR>

# The Swamp
import "./plugins.vim"
