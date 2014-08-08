
set nu

" Settings for using 4 spaces for tabs, and also 4 deletes for a backspace
set expandtab
set shiftwidth=4
set softtabstop=4

" Enable indentation for Python files. After this, the above tab-space
" thing is not required for Python files, but is still required for
" files with different extensions than .py
filetype indent on

" Indentation when working with plaintext files
set autoindent

" Map jj to escape key
imap jj <Esc>


