#! /bin/sh
echo "This config only works for neovim"
echo "Trying to use it with regular vim will generate a few error"
echo "If you want to fix these errors and make it truly portable"
echo "send a merge request to https://github.com/lorlouis/dotfiles"
cp -r ./home/config/nvim /home/"$USER"/.config/nvim
mkdir -p /home/"$USER"/Templates
cp -r ./home/Templates/* /home/"$USER"/Templates/
cp -r ./home/vim /home/"$USER"/.vim
cp -r ./home/vimrc /home/"$USER"/.vimrc

echo "Attempting to copy py_kw to /usr/share/dict/py_ky"

cp -r ./usr/share/dict/py_kw /usr/share/dict/py_kw
