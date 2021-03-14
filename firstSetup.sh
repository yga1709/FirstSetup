#!/bin/sh

LANG=C xdg-user-dirs-gtk-update

sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update

sudo apt install fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

sudo apt install vim

sudo apt install openssh-server
sudo ufw allow ssh

sudo apt install gnome-shell gnome-tweak-tool
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
gsettings set org.gnome.mutter experimental-features "['x11-randr-fractional-scaling']"


wget -P ~/Downloads  http://www.nicknorton.net/mousewheel.sh
chmod u+x ~/Downloads/mousewheel.sh
echo "マウスのスクロール速度を設定します"
sh ~/Downloads/mousewheel.sh

echo "設定ファイルを読み込みます"
git clone https://github.com/yga1709/Dotfiles.git
sh ./Dotfiles/dotfilesLink.sh
