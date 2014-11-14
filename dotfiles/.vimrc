
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

" Map jj in insert mode to escape key
imap jj <Esc>

" Break lines automatically at 79 characters
set textwidth=79

" Round off indent to multiple of 'shiftwidth' value
set shiftround

" Using this will change the current VIM directory to the location of the
" opened file. This is useful for working with tags. Note: tags can work
" without this option too, but you'll need to use './' before the tag file name
set autochdir

set tags=tags;
