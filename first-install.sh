#!/bin/bash
# Last Modified: 2023-05-31 14:51:07

#:默认脚本根路径
dotfilepath="~/.dotfiles"

cpto ()
{
  # 快速拷贝，适合数量较多目录
  # Ex: cpto source_dir target_dir 
  # tar cf - ${1} | (cd ${2}; tar xf -)
  tar cf - ${1} | pv | (cd ${2}; tar xf -)
}
# cpto . /dst

rm ~/.bashrc
rm ~/.bash_profile
rm ~/.ssh/known_hosts

# 先建立相关目录
mkdir -p ~/.local/bin/
mkdir -p ~/software/
mkdir -p ~/openwrt/
mkdir -p ~/install/ ~/.config/autostart

# download obsidian
cd ~/.local/bin/ && wget https://github.com/obsidianmd/obsidian-releases/releases/download/v0.15.9/Obsidian-0.15.9.AppImage && ln -s Obsidian-0.15.9.AppImage obsidian
# download alacritty
wget -O ~/.dotfiles/bash/.alacritty.bash https://github.com/alacritty/alacritty/raw/master/extra/completions/alacritty.bash
# download fishmarks ;Fishmarks is a clone of bashmarks for the Fish shell
curl -L https://github.com/techwizrd/fishmarks/raw/master/install.fish | fish

conda create -n hikyuu python=3.9
conda create -n pytest python=3.9
conda create -n py27 python=2.7

#neovim AppImage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version

# Optional: exposing nvim globally.
if [ -d "/squashfs-root" ]; then
  sudo rm -rf /squashfs-root/
fi
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

dnf copr enable agriffis/neovim-nightly
dnf install -y neovim python3-neovim

# https://github.com/LunarVim/LunarVim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
# bash <(proxychains curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
# uninstall lunarvim
# bash ~/.local/share/lunarvim/lvim/utils/installer/uninstall.sh
# git submodule add --depth=1 https://github.com/ryanoasis/nerd-fonts.git
# git submodule add --depth=1 https://github.com/magicmonty/bash-git-prompt.git 

# markdown-preview
yarn install
yarn build

# bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
dnf install -y black fish luarocks ruby cpan perl-App-cpanminus julia ruby-devel spawn tree-sitter-cli nodejs yarnpkg alacritty coreutils
# dnf install -y nodejs-bash-language-server
npm install -g tree-sitter
npm install -g neovim
npm install -g @fsouza/prettierd
npm install -g prettier
npm i -g bash-language-server shellcheck
LD_LIBRARY_PATH=/usr/local/lib64:/usr/lib64:/usr/lib64/mysql
gem install neovim
pip install isort tree-sittero
pip install --user doq
sudo cpanm -n Neovim::Ext
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


#-------------------------------------------------- 
# XDM Extension got deleted from chrome store
# https://github.com/subhra74/xdm/issues/895
# Clone here via git or download as zip:

# https://github.com/subhra74/xdm

# You will find "app" folder. Under it, there is "chrome" folder. You can add it directly to your chrome based browser as "unpacked extension". Don't forget to turn on developer settings in extension part of your chrome based browser.


#qemu
dnf install qemu-kvm libvirt-daemon-qemu libvirt virt-manager
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER

dnf install lm-sensors hddtemp -y


# How to add snippets to Lunarvim
# #https://github.com/sambergo/lunarvim-snippet-examples

