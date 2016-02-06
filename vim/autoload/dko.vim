function! dko#rtp() abort
  put! =split(&runtimepath, ',', 0)
endfunction

function! dko#init_object(var) abort
  let {a:var} = exists(a:var) ? {a:var} : {}
endfunction

" ============================================================================
" Status line
" ============================================================================

function! dko#status_mode() abort
  let l:modecolor = '%*'
  if mode() ==# 'i'
    let l:modecolor = '%#PmenuSel#'
  elseif mode() ==# 'v'
    let l:modecolor = '%#Cursor#'
  endif
  return  l:modecolor . ' %{mode()} %*'
endfunction

" a:winnr when called from autocmd in plugin/statusline.vim
function! dko#statusline(winnr) abort
  let l:contents = ''

  " mode
  let l:contents .= dko#status_mode()
  let l:contents .= !empty(&paste) ? '%#DiffText# p %*' : ''

  " --------------------------------------------------------------------------
  " File info
  " --------------------------------------------------------------------------

  if exists("g:plugs['vim-fugitive']") && a:winnr == winnr()
    let l:contents .= !empty(fugitive#head())
          \ ? '%#DiffAdd# %{fugitive#head()} %*'
          \ : ''
  endif

  " [&ft]
  let l:contents .= !empty(&ft) ? ' %y' : ''

  " truncated filename
  let l:contents .= ' %<%f '

  " --------------------------------------------------------------------------
  " Right side
  " --------------------------------------------------------------------------

  let l:contents .= '%='

  if exists("g:plugs['vim-anzu']") && a:winnr == winnr()
    let l:contents .= !empty(anzu#search_status())
          \ ? '%*%#SignColumn#' . ' %{anzu#search_status()} ' . '%*'
          \ : ''
  endif

  " ruler (10 char long, so can accommodate 9999x99999)
  let l:contents .= '%10.(%l:%c%) '

  " [help][Quickfix/Location List][Preview]
  let l:contents .= '%h%q%w'

  " Syntastic
  if exists("g:plugs['syntastic']") && a:winnr == winnr()
    let l:contents .= !empty(SyntasticStatuslineFlag())
          \ ? '%#SyntasticErrorSign#' . ' %{SyntasticStatuslineFlag()} ' . '%*'
          \ : ''
  endif

  return l:contents
endfunction
