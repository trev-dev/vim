vim9script

g:mapleader = " "

set nocompatible
syntax on

# Editor Settings
set t_Co=256
set termguicolors
set incsearch
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set listchars=tab:>·,trail:~
set list
set relativenumber
set cursorline
set cursorlineopt=number
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
set colorcolumn=100
set clipboard=unnamedplus

# Escape fixes for Kitty
set t_RV=

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

def g:ToggleConcealCursor()
  if (&concealcursor == '')
    set concealcursor=n
  else
    set concealcursor=
  endif
enddef

def g:ToggleConcealLevel()
  if (&conceallevel == 0)
    set conceallevel=2
  else
    set conceallevel=0
  endif
enddef

# Editor Keybinds
nmap <silent> <leader>tl :call ToggleList()<CR>
noremap <silent> <leader>tcc :call ToggleConcealCursor()<CR>
noremap <silent> <leader>tc :call ToggleConcealLevel()<CR>

# The Swamp
import "./plugins.vim"
