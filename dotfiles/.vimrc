
set nu

" Settings for using 4 spaces for tabs, and also 4 deletes for a backspace
set expandtab
set shiftwidth=4
set softtabstop=4

" Enable indentation for Python files. After this, the above tab-space
" thing is not required for Python files, but is still required for
" files with different extensions than .py
"
" Another note: if you write 'filetype on', it means the filetype detection
" plugin is 'on'. If you write 'filetype indent on', it means the filetype
" indent plugin is loaded, which also loads 'filetype' plugin (like when adding
" 'filetype on' to .vimrc).
"
" Note: this is commented out here, so that it should work well with pathogen,
" and the filetype indentation detection is added later again.
"" filetype indent on

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

" Incremental search. Highlights FIRST matching string as you type.
set incsearch

" Highlight search. After you type your search, when you press enter, it will
" highlight ALL matching strings. Note that it won't highlight matching strings
" as you type, but only when you press enter after you're done typing.
set hlsearch

execute pathogen#infect()
filetype off
syntax on

" The fillowing line means:
" 1. Filetype detection is on
" 2. Detecting and loading plugins for specific filetypes is on
" 3. Indentation detection for specific filetypes is on too
" Pathogen has some problem if this file is included before calling infect(),
" so adding after that.
filetype plugin indent on


" Allow folding of text. Python syntax is indent based, so make Vim detect
" folds based on indentation level. If only this line is set, all folds will
" start closed (value of 'foldlevel' is 0). To open/close fold, type'za'.
set foldmethod=indent

" The indentation level upto which lines are folded when you open the file.
" By default it is 0 (all folds closed). Value of 1 means in object-oriented
" Python code, upto class method definitions is shown. If
" this is changed to 'foldlevel=99', files will open without any folding
" already in place.
set foldlevel=1

" Maximum indentation depth upto which code is folded. If you use classes in
" Python, '2' means code will be folded at class level, and method level.
" Once you unfold a method, further indents (e.g. a 'for' loop) won't be folded
set foldnestmax=2

" These two settings work well if you want to start with folded code. If you
" prefer to start with unfolded code, these two lines will work best.
" (foldnestmax defaults to 20).
" set foldlevel=99
" set foldnestmax=20
