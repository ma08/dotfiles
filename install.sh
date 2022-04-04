sudo apt install rofi feh compton rxvt-unicode-256color

git submodule init
git submodule update
#git submodule foreach git submodule init
#git submodule foreach git submodule update
git submodule foreach git submodule update --init --recursive

cp -R ~/.vim ~/.vimdup
cp -R ~/.i3 ~/.i3dup
cp -R ~/.config/ranger ~/.config/rangerdup
cp -R ~/.mpd ~/.mpddup
cp -R ~/.ncmpcpp ~/.ncmpcppdup
cp -R ~/.vimperator ~/.vimperatordup

cp ~/.vimperatorrc ~/.vimperatorrcdup
cp ~/.vimrc ~/.vimrcdup
cp ~/.gvimrc ~/.gvimrcdup
cp ~/.i3status.conf ~/.i3status.confdup
cp ~/.Xresources ~/.Xresourcesdup


rm ~/.vimperatorrc
rm ~/.vimrc
rm ~/.Xresources
rm ~/.gvimrc
rm ~/.i3status.conf

rm -rf ~/.vim
rm -rf ~/.i3
rm -rf ~/.mpd
rm -rf ~/.ncmpcpp
rm -rf ~/.vimperator
rm -rf ~/.config/ranger


ln -s $(pwd)/ranger ~/.config/ranger
ln -s $(pwd)/ncmpcpp ~/.ncmpcpp
ln -s $(pwd)/mpd ~/.mpd
ln -s $(pwd)/vimperator ~/.vimperator
ln -s $(pwd)/vim ~/.vim
ln -s $(pwd)/i3 ~/.i3

ln -s $(pwd)/bashrc ~/.bashrc
ln -s $(pwd)/Xresources ~/.Xresources
ln -s $(pwd)/vim/.vimrc ~/.vimrc
ln -s $(pwd)/vscode/.vimrc ~/.vscode_vimrc
ln -s $(pwd)/vim/.gvimrc ~/.gvimrc
ln -s $(pwd)/vimperator/.vimperatorrc ~/.vimperatorrc
ln -s $(pwd)/i3/i3status.conf ~/.i3status.conf


#cd ~/.vim/bundle/YouCompleteMe
#./install.sh --clang-completer --system-libclang --system-boost
