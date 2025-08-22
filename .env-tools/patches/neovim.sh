#!/bin/bash

nvimDir="${HOME}/.local/env-tools/nvim"

version="v0.11.0"
if [ ! -z $NVIM_VERSION ]; then
    version="$NVIM_VERSION"
fi

if [[ -n "$(which nvim)" ]]; then
	echo "[INFO] Skipping neovim"
    exit
fi

echo "neovim version: \"$version\""

if [ ! -d $nvimDir ]; then
    git clone https://github.com/neovim/neovim.git $nvimDir
fi

sudo apt -y install cmake gettext lua5.1 liblua5.1-0-dev

git -C $nvimDir fetch --all
git -C $nvimDir checkout $version

make -C $nvimDir clean
make -C $nvimDir CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make -C $nvimDir install
