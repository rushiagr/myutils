#! /bin/bash -ux


# DO NOT RUN THIS FILE. Skip directly to last section

cd ~/.vim/bundle
git clone https://github.com/haya14busa/incsearch.vim
git clone https://github.com/tomtom/tlib_vim
git clone https://github.com/MarcWeber/vim-addon-mw-utils
git clone https://github.com/garbas/vim-snipmate
git clone https://github.com/nvie/vim-flake8
git clone https://github.com/tomtom/tcomment_vim

# Directly copy vim plugins from github
cd ~/.vim/plugin
wget https://raw.githubusercontent.com/907th/vim-auto-save/master/plugin/AutoSave.vim

# LAST SECTION
Use pathogen, and then add following plugins
https://github.com/haya14busa/incsearch.vim
https://github.com/vim-scripts/vim-auto-save
https://github.com/tomtom/tcomment_vim
