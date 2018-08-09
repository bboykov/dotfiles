function! myspacevim#before() abort
  let g:spacevim_automatic_update = 1
  let g:python_host_prog = '$HOME/.pyenv/versions/neovim2/bin/python'
  let g:python3_host_prog = '$HOME/.pyenv/versions/neovim3/bin/python'
  inoremap jj <ESC>
endfunction

function! myspacevim#after() abort
  " inoremap jj <ESC>
endfunction
