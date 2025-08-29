# Wheelebin Dots

My personal dotfiles repo.

## Architecture

This setup uses a [bare Git repository approach](https://www.atlassian.com/git/tutorials/dotfiles) for version control.

**Directory Structure:**
- `.config/` - Configuration files
- `.env-tools/` - Bash scripts for software installation and environment setup

## Installation

### Prerequisites
- Git
- SSH access to Github

### Setup on New Machine

#### Init steps (Auto)
- . **Run all of the init steps via init.sh script**
   ```bash
   curl https://raw.githubusercontent.com/wheelebin/dots/refs/heads/master/.env-tools/init.sh | /bin/bash
   ```

#### Init steps (Manual)
1. **Add the configuration alias to your shell profile:**
   
   Add this to your `.bashrc` or `.zshrc`:
   ```bash
   alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
   ```

2. **Prevent the bare repository folder from being tracked:**
   ```bash
   echo ".cfg" >> .gitignore
   ```

3. **Clone the dotfiles repository as a bare repository:**
   ```bash
   git clone --bare git@github.com:wheelebin/dots.git $HOME/.cfg
   ```

4. **Define the alias for the current shell session:**
   ```bash
   alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
   ```

5. **Checkout the configuration files:**
   ```bash
   config checkout
   ```

#### Install software deps

- **Run the setup script to install software deps:**
   ```bash
   ./.env-tools/main.sh setup
   ```

## Usage

After installation, use the `config` command instead of `git` to manage your dotfiles:

```bash
# Check status
config status

# Add changes
config add .vimrc

# Commit changes
config commit -m "Update vim configuration"

# Push changes
config push
```

## Git User Management

### Default Configuration
The repository is configured to use the `wheelebin` user by default for all Git operations.

### Work Configuration
To use different Git credentials for work-related repositories:

1. **Create a work-specific Git configuration file:**
   ```bash
   # Create ~/.gitconfig-wrk (do not commit this file)
   cat > ~/.gitconfig-wrk << EOF
   [user]
       email = work.email@company.com
       name = Work Name
   EOF
   ```

2. **Organize work projects:**
   
   Place all work-related repositories in the `~/wrk/` directory. The Git configuration will automatically use your work credentials for any repository within this path.

### Configuration Logic
- **Personal projects**: Use default `wheelebin` credentials
- **Work projects** (in `~/wrk/`): Use credentials from `~/.gitconfig-wrk`

## Notes

### Hiding Untracked Files
To avoid seeing untracked files in your home directory:
```bash
config config --local status.showUntrackedFiles no
```
