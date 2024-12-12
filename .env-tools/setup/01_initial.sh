#!/bin/bash

sudo apt -y update
sudo apt -y install zsh tmux curl unzip


# Make zsh default shell
chsh -s $(which zsh)

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# pull dotfiles
#echo "CLEARING OLD STUFF"
#rm $HOME/.gitignore
#rm -fr $HOME/.config
#rm -fr $HOME/.cfg
#echo ".cfg" >> $HOME/.gitignore

#git clone --bare https://github.com/wheelebin/dots.git $HOME/.cfg

#configCMD="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
#mkdir -p $HOME/.config-backup
#$configCMD checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv $HOME/{} $HOME/.config-backup/{}
#$configCMD checkout


# fnm & latest LTS node version
export SHELL="/bin/zsh"
curl -fsSL https://fnm.vercel.app/install | zsh -s -- --skip-shell
zsh -c "source $HOME/.zshrc; fnm install --lts"
