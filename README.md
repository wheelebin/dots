# Wheelebin DOTS

## Overview
- Version control for files is based on [Bare Git Repo Setup](https://www.atlassian.com/git/tutorials/dotfiles)
- .config contains most configuration files
- .env-tools contains bash scripts for installing needed software

## Get started
### Init on new computer

#### Add bellow alias to .bashrc or .zshrc
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

#### Make sure bare repo folder is ignored
```bash
echo ".cfg" >> .gitignore
```

#### Clone dot files into bare repo folder
```bash
git clone --bare git@github.com:wheelebin/dots.git $HOME/.cfg
```

#### Define alias in current shell scope
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

#### Checkout content from bare repo to $HOME
```bash
config checkout
```

#### Run setup script
```bash
./.env-tools/main.sh setup
```

## Managing personal & work git users
- By default wheelebin user will be used as the git user. 
- If a different git user is needed for work add a ~/.gitconfig-wrk with the bellow config. (Do not commit this file)
	- Now, any folders placed in ~/wrk/** will use the work git user

```
[user]
	email = [WORK_EMAIL]
	name = [WORK_NAME]
```


