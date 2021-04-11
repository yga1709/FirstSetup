#!/bin/sh

yorn(){
    clear
	ret=-1;
	while true;do
		echo $1;
		read answer;
		case $answer in
			y)
				echo "Tyeped Yes.";
				ret=0;
				return 0;
				;;
			Y)
				echo "Tyeped Yes.";
				ret=0;
				return 0;
				;;
			n)
				echo "Tyeped No.";
				ret=1;
				return 1;
				;;
			N)
				echo "Tyeped No.";
				ret=1;
				return 1;
				;;
			*)
				echo "Cannot Understand $answer.\nY or N Typed!";
				;;
		esac
	done
}

LANG=C xdg-user-dirs-gtk-update

FishInstall(){
    yorn "Fishをインストールしますか？ (Y)yes/(N)no"
    if [ $ret -eq 0 ] ; then
        sudo apt-add-repository ppa:fish-shell/release-3
        sudo apt update

        sudo apt install --yes fish
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
        echo "Fishのインストールが完了しました"
    else
        echo "キャンセルしました"
    fi
}

AppInstall(){
    echo "Vimをインストールします"
    sudo apt install --yes vim
    sudo apt install --yes openssh-server
    sudo ufw allow ssh

    echo "GnomeShellをインストールします"
    sudo apt install --yes gnome-shell gnome-tweak-tool

    echo "Gitをインストールします"
    sudo apt install --yes git

    echo "ffmpegをインストールします"
    sudo apt install --yes ffmpeg
}

PythonSetting(){
    yorn "Python環境を構築しますか？ (Y)yes/(N)no"
    if [ $ret -eq 0 ] ; then
        sudo apt install --yes python3-pip
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
        sudo pip3 install virtualenvwrapper
        echo "
        set PATH \$HOME/.pyenv/bin \$PATH
        set PATH \$HOME/.pyenv/shims \$PATH
        set PATH \$HOME/.local/bin \$PATH
        " >> ~/.config/fish/config.fish
        echo "Python環境の構築が完了しました"
    else
        echo "キャンセルしました"
    fi
}

HighDpiSetting(){
    yorn "4Kモニタ向けの設定を行いますか？ (Y)yes/(N)no"
    if [ $ret -eq 0 ] ; then
        gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
        gsettings set org.gnome.mutter experimental-features "['x11-randr-fractional-scaling']"
        echo "4Kモニタ向けの設定を行いました"
    else
        echo "キャンセルしました"
    fi
}


MouseScrollSpeed(){
    echo "マウスのスクロール速度を設定しますか？ (Y)yes/(N)no"
    if [ $ret -eq 0 ] ; then
        wget -P ~/Downloads  http://www.nicknorton.net/mousewheel.sh
        chmod u+x ~/Downloads/mousewheel.sh
        sh ~/Downloads/mousewheel.sh
    else
        echo "キャンセルしました"
    fi
}


SettingDotFile(){
    yorn "設定ファイルを読み込みますか？  (Y)yes/(N)no"
    if [ $ret -eq 0 ] ; then
        git clone https://github.com/yga1709/Dotfiles.git
        sh ./Dotfiles/dotfilesLink.sh
        echo "設定ファルの読み込みが完了しました"
    else
        echo "キャンセルしました"
    fi
}

NemoInstall(){
    yorn "デフォルトのファイルマネージャーをNemoへ変更しますか？ (Y)yes/(N)no"
    if [ $ret -eq 0 ] ; then
        sudo apt install --yes nemo
        xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
        gsettings set org.gnome.desktop.background show-desktop-icons false
        gsettings set org.nemo.desktop show-desktop-icons true
        echo "Nemoへの変更が完了しました"

        yorn "Nemo-previewをインストールしますか？ (Y)yes/(N)no"
        if [ $ret -eq 0 ] ; then
            mkdir ~/nemo_preview
            cd ~/nemo_preview
            wget http://packages.linuxmint.com/pool/backport/n/nemo-preview/nemo-preview_4.6.0+ulyana_amd64.deb
            wget http://packages.linuxmint.com/pool/backport/x/xreader/gir1.2-xreader_2.8.3+ulyssa_amd64.deb
            wget http://packages.linuxmint.com/pool/backport/x/xreader/libxreaderview3_2.8.3+ulyssa_amd64.deb
            wget http://packages.linuxmint.com/pool/backport/x/xreader/libxreaderdocument3_2.8.3+ulyssa_amd64.deb
            sudo apt install --yes ./gir1.2-xreader_2.8.3+ulyssa_amd64.deb ./libxreaderdocument3_2.8.3+ulyssa_amd64.deb ./libxreaderview3_2.8.3+ulyssa_amd64.deb ./nemo-preview_4.6.0+ulyana_amd64.deb
            sudo apt install --yes gir1.2-gtksource-3.0
            rm -rf ~/nemo_preview
            echo "Nemo-previewのインストールが完了しました"
        fi
    else
        echo "キャンセルしました"
    fi
}

FishInstall;

AppInstall;

PythonSetting;

HighDpiSetting;

MouseScrollSpeed;

SettingDotFile;

NemoInstall;
