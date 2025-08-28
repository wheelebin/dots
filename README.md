# Wheelebin DOTS

## Overview
- Version control for files is based on [Bare Git Repo Setup](https://www.atlassian.com/git/tutorials/dotfiles)
- .config contains most configuration files
- .env-tools contains bash scripts for installing needed software

## Git
By default wheelebin user will be used as the git user. If a different git user is needed for work add a ~/.gitconfig-wrk with the bellow config. Do not commit this file.

```
[user]
	email = [WORK_EMAIL]
	name = [WORK_NAME]
```

Now, any folders placed in ~/wrk/** will use the work git user
