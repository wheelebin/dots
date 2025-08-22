#!/bin/bash

sudo apt -y update
sudo apt -y install zsh tmux curl unzip

mkdir -p .local/env-utils

# Make zsh default shell
chsh -s $(which zsh)

# oh-my-zsh
if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	yes | cp ~/.zshrc.pre-oh-my-zsh ~/.zshrc
else
	echo "[INFO] Skipping oh-my-zsh"
fi

# fnm & latest LTS node version
if [[ ! -n "$(which fnm)" ]]; then
	export SHELL="/bin/zsh"
	curl -fsSL https://fnm.vercel.app/install | zsh -s -- --skip-shell
	zsh -c "source $HOME/.zshrc; fnm install --lts"
else
	echo "[INFO] Skipping fnm & node"
fi

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# Install ripgrep
sudo apt install ripgrep

# Go via updategolang
# TODO: Add hash check to this and other remote & pull installs
# See: https://github.com/udhos/update-golang?tab=readme-ov-file#caution
#if [[ ! -d $HOME/.local/env-tools/update-golang ]]; then
#	git clone https://github.com/udhos/update-golang.git $HOME/.local/env-tools/update-golang
#	sudo /bin/bash $HOME/.local/env-tools/update-golang/update-golang.sh
#	cat /etc/profile.d/golang_path.sh >> .zshenv
#else
#	echo "[INFO] Skipping update-golang"
#fi
