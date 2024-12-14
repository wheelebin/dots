package patches

import (
	"fmt"
	"os"

	"github.com/wheelebin/go-test/lib"
)

func golang() {
	// https://github.com/udhos/update-golang
}

func shell() {
	lib.Log(lib.INFO, "shell")
	lib.ExecCmd("sudo", "apt", "-y", "install", "zsh", "tmux")

	lib.Log(lib.INFO, "make zsh default")
	lib.ExecCmd("sudo", "chsh", "-s", "$(which zsh)")

	lib.Log(lib.INFO, "oh-my-zsh")
	err := lib.ExecCmd("sh", "-c", "curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended")
	if err == nil {
		lib.ExecCmd("cat", "~/.zshrc.pre-oh-my-zsh", ">>", "~/.zshrc")
	}

	os.Setenv("SHELL", "/bin/zsh")
	lib.ExecCmd("zsh", "-c", "source ~/.zshrc && exec zsh")

	err = lib.ExecCmd("curl", " -fsSL https://fnm.vercel.app/install | zsh -s -- --skip-shell")
	fmt.Println(err)
}

func Test() (string, error) {

	lib.Log(lib.INFO, "update & general deps")
	lib.ExecCmd("sudo", "apt", "-y", "update")
	lib.ExecCmd("sudo", "apt", "-y", "install", "curl", "unzip")

	shell()

	return "", nil

}

// #!/bin/bash
//
// sudo apt -y update
// sudo apt -y install zsh tmux curl unzip
//
// # Make zsh default shell
// chsh -s $(which zsh)
//
// # oh-my-zsh
// sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
// cat ~/.zshrc.pre-oh-my-zsh >> ~/.zshrc
//
// # fnm & latest LTS node version
// export SHELL="/bin/zsh"
// curl -fsSL https://fnm.vercel.app/install | zsh -s -- --skip-shell
// zsh -c "source $HOME/.zshrc; fnm install --lts"
