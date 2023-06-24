" basic settings---------------------------
set encoding=utf8
set number
set ruler
set cursorline
set cursorcolumn
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
"End basic settings-----------------------

function! AddIndentWhenEnter()
  if getline(".")[col(".")-1] == "}" && getline(".")[col(".")-2] == "{"
    return "\n\t\n\<UP>\<END>"
  else
    return "\n"
  endif
endfunction
inoremap <silent> <expr> <CR> AddIndentWhenEnter()
"Color Settings--------------------------
syntax on

if (has('termguicolors'))
  set termguicolors
endif
"End Color Settings----------------------
