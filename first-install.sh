#!/bin/bash
#:che 
dotfilepath="~/.dotfiles"

rm ~/.bashrc
rm ~/.bash_profile
rm ~/.ssh/known_hosts

# 先建立相关目录
mkdir -p ~/.local/bin/
mkdir -p ~/software/
mkdir -p ~/openwrt/

# download obsidian
cd ~/.local/bin/ && wget https://github.com/obsidianmd/obsidian-releases/releases/download/v0.15.9/Obsidian-0.15.9.AppImage && ln -s Obsidian-0.15.9.AppImage obsidian
# download alacritty
wget -O ~/.dotfiles/bash/.alacritty.bash https://github.com/alacritty/alacritty/raw/master/extra/completions/alacritty.bash

conda create -n hikyuu python==3.9
conda create -n pytest python==3.9

dnf install -y fish luarocks ruby cpan julia black ruby-devel nodejs yarnpkg alacritty coreutils
npm install -g tree-sitter
npm install -g neovim
npm install -g @fsouza/prettierd
npm install -g prettier
LD_LIBRARY_PATH=/usr/local/lib64:/usr/lib64:/usr/lib64/mysql
gem install neovim
pip install isort
# oh-my-fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
# fisher
proxychains curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# source code pro fonts
FONT_NAME="SourceCodePro"
URL="https://github.com/adobe-fonts/source-code-pro/archive/1.017R.zip"
URL="https://fonts.google.com/download?family=Source%20Code%20Pro"
mkdir /tmp/adodefont
cd /tmp/adodefont
wget ${URL} -O ${FONT_NAME}.zip
unzip -o -j ${FONT_NAME}.zip
mkdir -p ~/.local/share/fonts
cp *.otf ~/.local/share/fonts
fc-cache -f -v

# 显示器设置黑屏   设置-》显示器 -》内置显示器 -》不勾选

