vim9script

# Package Configs

## COC {{{
def g:ShowDocumentation()
  if g:CocAction('hasProvider', 'hover')
    g:CocActionAsync('doHover')
  else
    feedkeys('K', 'in')
  endif
enddef

g:coc_status_error_sign = " "
g:coc_status_warning_sign = " "

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

### Navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call ShowDocumentation()<CR>

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
g:db_ui_use_nerd_fonts = 1
nmap <silent> <leader>du :DBUI<CR>
nmap <silent> <leader>db 0"dy$:DB <c-r>d<CR>
vmap <silent> <leader>db :DB<CR>
nmap <silent> <leader>dr :DB ROLLBACK;<CR>
# }}}

## Emmet {{{
g:user_emmet_leader_key = '<C-k>'
# }}}

## Floaterm {{{
g:floaterm_keymap_toggle = '<leader>T'
g:floaterm_width = 0.95
g:floaterm_height = 0.95

noremap <silent> <leader>tg :FloatermNew --autoclose=1 --title=lazygit lazygit<CR>
noremap <silent> <leader>tw :FloatermNew --autoclose=2 --title=taskwarrior taskwarrior-tui<CR>
# }}}

## FZF {{{
g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
g:fzf_layout = {
  'window': {
    'width': 1.0,
    'height': 0.6,
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

## GitGutter {{{
g:gitgutter_sign_added = '┃'
g:gitgutter_sign_modified = '┃'
g:gitgutter_sign_removed = '┃'
g:gitgutter_sign_removed_first_line = '┏'
g:gitgutter_sign_removed_above_and_below = '┣'
g:gitgutter_sign_modified_removed = '┇'
# }}}

## git-lens.vim {{{
command! GitLens :call ToggleGitLens()<CR>
# }}}

## Vim Cool {{{
g:cool_total_matches = 1
# }}}

## IndentLines {{{
g:indentLine_char = '▏'
g:indentLine_fileTypeExclude = [
  '',
  'dbout',
  'help',
  'markdown',
  'message',
  'org',
  'vimwiki'
]
nmap <silent> <leader>ti :IndentLinesToggle<CR>
# }}}

## NERDTree {{{
nmap <silent> <leader>n :NERDTreeToggle<CR>
# }}}

## Ledger {{{
g:ledger_extra_options = '--strict'
#}}}

## MKDX {{{
g:mkdx#settings = {
  'highlight': { 'enable': 1 },
  'enter': { 'shift': 2 }
}
# }}}

## Polyglot {{{
g:polyglot_disabled = ['markdown']
g:vim_svelte_plugin_use_typescript = 1
# }}}

## Stargate {{{
noremap <leader>ss :call stargate#OKvim(1)<CR>
noremap <leader>sw :call stargate#OKvim('\<')<CR>
noremap <c-w>g :call stargate#Galaxy()<CR>
# }}}

## Vim-Argwrap {{{
nnoremap <silent> <leader>aw :ArgWrap<CR>
#}}}

## Vimspector {{{
g:vimspector_enable_mappings = 'HUMAN'
g:vimspector_sign_priority = {
  'vimspectorBP': 11,
  'vimspectorPC': 999
}
# }}}

## Wiki.vim {{{
g:wiki_root = "~/Wiki"
g:wiki_filetypes = ["md"]
g:wiki_link_extension = ".md"
g:wiki_link_target_type = "md"

def FrontmatterTagParser(str: string): list<string>
  return str
    -> substitute('"\|''', '', 'g')
    -> matchstr('^tags:\s*\[\zs.*\ze]')
    -> split('[ , ]\+')
enddef

def MakeFrontmatterTags(tags: list<string>): string
  if empty(tags) | return 'tags: []' | endif
  const newTags = "tags: ['" .. join(tags, "', '") .. "']"
  return newTags
enddef

# parse tags in lines that match "tags: keyword1, keyword2" in addition to the default parser:
g:wiki_tag_parsers = [
  {
    'match': (x) => x =~ '^#\w\+',
    'parse': (x) => x->substitute('#', '', 'g')->split(' \+'),
    'make': (t, _x) => '#' .. join(t, ' #')
  },
  {
    'match': (x) => x =~ '^tags:\s*[',
    'parse': (x) => FrontmatterTagParser(x),
    'make': (t, _x) => MakeFrontmatterTags(t)
  }
]

def FormatJournalTitle(isodate: string, path: string): string
  const time = strptime("%Y-%m-%d", isodate)
  return strftime("%b %d", time) .. ": " .. wiki#toc#get_page_title(path)
enddef

def FormatJournalLink(path: string): string
  return wiki#paths#relative(wiki#get_root() .. path, expand('#:p:h'))
enddef

g:wiki_journal_index = {
  'link_text_parser': (_basename, date, path) => FormatJournalTitle(date, path),
  'link_url_parser': (_basename, _date, path) => FormatJournalLink(path)
}

nmap <silent> <leader>fwp :WikiPages<CR>
nmap <silent> <leader>fwt :WikiTags<CR>
# }}}

# Theme {{{
if (has("autocmd"))
  def ExtendOneDark()
    const cursorlinenum = { "fg": { "gui": "#E5C07B" } }
    const linenr = { "fg": { "gui": "#777777" } }
    const incsearch = {
      "fg": { "gui": "#191919", "cterm": 16 },
      "bg": { "gui": "#56B6C2", "cterm": 45 }
    }
    onedark#extend_highlight("IncSearch", incsearch)
    onedark#set_highlight("CurSearch", incsearch)
    onedark#extend_highlight("CursorLineNr", cursorlinenum)
    onedark#extend_highlight("CursorLineNr", cursorlinenum)
    onedark#extend_highlight("LineNr", linenr)
  enddef
  augroup colorextend
    autocmd!
    autocmd ColorScheme * ExtendOneDark()
  augroup END
endif

g:onedark_color_overrides = {
  'background': { "gui": "#191919", "cterm": "235", "cterm16": "NONE" },
  'black': { "gui": "#191919", "cterm": "235", "cterm16": "0" },
  'comment_grey': { "gui": "#ABB2BF", "cterm": "59", "cterm16": "7" },
  'cursor_grey': { "gui": "#303030", "cterm": "236", "cterm16": "0" },
  'visual_grey': { "gui": "#444444", "cterm": "237", "cterm16": "8" },
  'foreground': { "gui": "#EEEEFF", "cterm": "145", "cterm16": "15" },
  'menu_grey': { "gui": "#303030", "cterm": "237", "cterm16": "7" }
}

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
