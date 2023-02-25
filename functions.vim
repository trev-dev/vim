vim9script

def g:ToggleList()
  const fullChars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣"
  const trailingChars = "tab:>·,trail:~"
  if (&listchars == fullChars)
    &listchars = trailingChars
  else
    &listchars = fullChars
  endif
enddef
