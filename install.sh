#! /bin/sh
echo "This config only works for neovim"
echo "Trying to use it with regular vim will generate a few error"
echo "If you want to fix these errors and make it truly portable"
echo "send a merge request to https://github.com/lorlouis/dotfiles"

mkdir -p /home/"$USER"/.config/nvim/ftdetect
cp ./home/config/nvim/ftdetect/* /home/"$USER"/.config/nvim/ftdetect/
mkdir -p /home/"$USER"/.config/nvim/syntax
cp ./home/config/nvim/syntax/* /home/"$USER"/.config/nvim/syntax/
cp -f ./home/config/nvim/init.vim /home/"$USER"/.congig/nvim/init.vim

mkdir -p /home/"$USER"/Templates
cp ./home/Templates/* /home/"$USER"/Templates/

mkdir -p /home/"$USER"/.vim/ftdetect
cp ./home/vim/ftdetect/* /home/"$USER"/.vim/ftdetect/
mkdir -p /home/"$USER"/.vim/syntax
cp ./home/vim/syntac/* /home/"$USER"/.vim/syntac/
cp -f ./home/vimrc /home/"$USER"/.vimrc

echo "Attempting to copy py_kw to /usr/share/dict/py_ky"
mkdir -p /usr/share/dict/
cp -r ./usr/share/dict/py_kw /usr/share/dict/py_kw
