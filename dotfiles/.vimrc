set number "also equal to 'set nu'

" Settings for using 4 spaces for tabs, and also 4 deletes for a backspace
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

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

" Also try jk and kj, so that when I press both keys together, I escape the
" insert mode
imap jk <Esc>
imap kj <Esc>

" Break lines automatically at 79 characters
"set textwidth=79

" Put a column at 79 characters, so that one can break lines manually,
" and make the textwidth thing NOT do it automatically, which becomes a huge
" pain sometimes
set colorcolumn=79

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

" au means autocmd. Writing 'autocmd BufNewFile,BufRead <pattern> <setting>
" will make the '<setting>' apply only to files matching '<pattern>'. E.g.:
" au BufNewFile,BufRead *.py set textwidth=79 will make textwidth=79 only to
" python files
" NOTE: use 'setlocal' instead of 'set', as otherwise the setting will be
" applied to all files opened in vim and not just the current, local file
autocmd BufNewFile,BufRead *.py setlocal textwidth=79
autocmd BufNewFile,BufRead *.vimrc setlocal textwidth=79
" Switch on syntax highlighting for Vagrantfile files
au BufNewFile,BufRead Vagrantfile setlocal filetype=ruby


map /  <Plug>(incsearch-forward)

" Flake8 mappings

" Shows a marker in the file, where there is an error
let g:flake8_show_in_file=1

" Shows the marker for erring line in the gutter (before line number)
let g:flake8_show_in_gutter=1

" Open quickfix window. This is 1 by default. Left here if need to change in
" future
let g:flake8_show_quickfix=1

" Run flake8 every time while saving the file
" autocmd BufWritePost *.py call Flake8()


"The following lines do this:
"Highlight trailing whitespace in red
"Have this highlighting not appear whilst you are typing in insert mode
"Have the highlighting of whitespace apply when you open new buffers
highlight ExtraWhitespace ctermbg=161 guibg=161
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Remove all whitespaces from files of specific fileformat just before saving
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.sh :%s/\s\+$//e
autocmd BufWritePre *.yaml :%s/\s\+$//e

" Function to remove trailing newlines from end of file
" NOTE: This should be called after removing all whitespaces from file, else
" trailing lines which contain whitespaces won't be removed probably. Hopefully
" writing this BufWritePre before the above BufWritePre will work as expected
function TrimEndLines()
    let save_cursor = getpos(".")
    :silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction
au BufWritePre *.py call TrimEndLines()

" Use my own colorscheme
colorscheme pygun

" Now pressing "sa" will copy the whole file to clipboard
nnoremap sa gg"+yG

" Allows copying and pasting to and from VIM to system's clipboard. Note that
" this doesn't work over an SSH connection.
" NOTE: on Mac, the value should be "unnamed", and on Ubuntu, should be
" "unnamedplus"
set clipboard=unnamed

" ** Mac hack **
" In vim installed with brew, there was a weird problem: any word which was
" not written in the current 'insert mode' session, was not getting deleted
" by either pressing backspace or by pressing CTRL+w in that insert mode
" session. Adding this line solves that issue. Note that this command doesn't
" alter backspace behavior on an Ubuntu system
set backspace=2

" Every time I'll press '#t ', this will expand it to show '# TODO(rushiagr):'
:abbreviate #t # TODO(rushiagr):


" TComment plugin has CTRL+_ CTRL+_ as the shortcut for commenting/uncommenting
" a line or selected text. Here, I'm mapping it to CTRL+l, for easier access
map <c-l> <c-_><c-_>

" Following three lines are required to make vim modelines work. An example of
" modeline you can use is below. You require modeline to be in exact same
" format, including spaces and colons exactly as described below, else it might
" not work:
"     # vim: set shiftwidth=2 textwidth=80:
" Not sure if the second line is required, as we're already doing the same
" thing above in this .vimrc file. Also, note that specifying options in .vimrc
" instead of writing modelines is a better way of managing specific vim options
" for specific files, so try to avoid modelines as much as possible.
set nocompatible
filetype plugin on
set modeline
