#!/bin/bash

sudo apt -y update
sudo apt -y install zsh tmux curl unzip

mkdir -p .local/env-utils

# Make zsh default shell
chsh -s $(which zsh)

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
#cat ~/.zshrc.pre-oh-my-zsh >> ~/.zshrc 
yes | cp ~/.zshrc.pre-oh-my-zsh ~/.zshrc

# fnm & latest LTS node version
export SHELL="/bin/zsh"
curl -fsSL https://fnm.vercel.app/install | zsh -s -- --skip-shell
zsh -c "source $HOME/.zshrc; fnm install --lts"

# Go via updategolang
# TODO: Add hash check to this and other remote & pull installs
# See: https://github.com/udhos/update-golang?tab=readme-ov-file#caution
if [[ ! -d $HOME/.local/env-tools/update-golang ]]; then
	git clone git@github.com:udhos/update-golang.git $HOME/.local/env-tools/update-golang
	sudo /bin/bash $HOME/.local/env-tools/update-golang/update-golang.sh
	cat /etc/profile.d/golang_path.sh >> .zshenv
fi
