vim9script

# Package List

# {{{
plug#begin('~/.vim/plugged')
# Theming
Plug 'jacoborus/tender.vim'
Plug 'trev-dev/gentle.vim'
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons'

# Editor
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'markonm/traces.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'vimwiki/vimwiki'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'jamessan/vim-gnupg'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

# Syntax
Plug 'sheerun/vim-polyglot'
plug#end()
# }}}

# Package Configs

## COC {{{
def g:ShowDocumentation()
  if g:CocAction('hasProvider', 'hover')
    g:CocActionAsync('doHover')
  else
    feedkeys('K', 'in')
  endif
enddef

autocmd CursorHold * silent call CocActionAsync('highlight')

g:coc_status_error_sign = " "
g:coc_status_warning_sign = "⚠ "

### Navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call ShowDocumentation()<CR>

### Completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

### Code Actions
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

# Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
# Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
# Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

### Refactor
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
command! -nargs=0 Format :call CocActionAsync('format')
# }}}

## Dadbod {{{
nmap <silent> <leader>gd :DBUI<CR>
nmap <silent> <leader>db :DB<CR>
# }}}

## FZF {{{
g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
g:fzf_layout = {
  'window': {
    'width': 1.0,
    'height': 0.6,
    'relative': v:true,
    'yoffset': 1.0
  }
}

nmap <silent> <leader>ff :Files<CR>
nmap <silent> <leader>fg :GFiles<CR>
nmap <silent> <leader>fG :GFiles?<CR>
nmap <silent> <leader>fb :Buffers<CR>
nmap <silent> <leader>fr :Rg<CR>
nmap <silent> <leader>fl :BLines<CR>
nmap <silent> <leader>fL :Lines<CR>
nmap <silent> <leader>fm :Marks<CR>
nmap <silent> <leader>fM :Maps<CR>
nmap <silent> <leader>fh :History<CR>
nmap <silent> <leader>fc :BCommits<CR>
nmap <silent> <leader>fC :Commits<CR>
# }}}

## IndentLines {{{
g:indentLine_char = '▏'
nmap <silent> <leader>ti :IndentLinesToggle<CR>
# }}}

## NERDTree {{{
nmap <silent> <leader>n :NERDTreeToggle<CR>
# }}}

## Polyglot {{{
g:vim_svelte_plugin_use_typescript = 1
# }}}

## GitGutter {{{
g:gitgutter_sign_added = '┃'
g:gitgutter_sign_modified = '┃'
g:gitgutter_sign_removed = '┃'
g:gitgutter_sign_removed_first_line = '┏'
g:gitgutter_sign_removed_above_and_below = '┣'
g:gitgutter_sign_modified_removed = '┇'
# }}}

## VimWiki {{{
g:vimwiki_list = [{
  'path': '~/Wiki',
  'syntax': 'markdown',
  'ext': '.md'
}]
# }}}

# Theme {{{
if (has("autocmd") && !has("gui_running"))
  def SetOneDark()
    const bg = { "fg": { "gui": "#ABB2BF", "cterm": "145", "cterm16": "7" } }
    onedark#set_highlight("Normal", bg)
  enddef
  augroup colorset
    autocmd!
    autocmd ColorScheme * SetOneDark()
  augroup END
endif

if (has("autocmd"))
  def ExtendOneDark()
    const comment = { "fg": { "gui": "#E06C75", "cterm": 204 } }
    onedark#extend_highlight("Comment", comment)
  enddef
  augroup colorextend
    autocmd!
    autocmd ColorScheme * ExtendOneDark()
  augroup END
endif

colorscheme onedark

g:lightline = {
  'colorscheme': 'onedark',
  'active': {
    'left': [ [ 'mode', 'paste' ],
      [ 'readonly', 'filename', 'modified', 'gitbranch' ],
      [ 'cocstatus' ] ]
  },
  'component_function': {
    'cocstatus': 'coc#status',
    'currentfunction': 'CocCurrentFunction',
    'gitbranch': 'FugitiveHead'
  }
}
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

set laststatus=2
# }}}

# vim: fdm=marker
