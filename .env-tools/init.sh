#!/bin/bash

shopt -s expand_aliases
set -euo pipefail

readonly DOTS_REPO="git@github.com:wheelebin/dots.git"
readonly DOTS_DIR="${HOME}/.cfg"

function log() {
    echo "[$1]: $2" >&2;
}

shellConfigHasAlias=false

# Find shell config
for config in "${HOME}/.zshrc" "${HOME}/.bashrc"; do
    if [[ -f "$config" ]]; then
        shell_config="$config"
        break
    fi
done

if [[ -z "${shell_config:-}" ]]; then
    log ERROR "Could not find .zshrc or .bashrc";
    exit 1;
fi

log INFO "Using $shell_config"

# Add alias if not exists
if grep -q "alias config=" "$shell_config" 2>/dev/null; then
    log INFO "Alias already configured (skipping)"
else
    log INFO "Adding alias to config"
    echo "alias config='/usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'" >> "$shell_config"
fi

# Add to gitignore if not exists
if cat "${HOME}/.gitignore" | grep -q ".cfg" 2>/dev/null; then
    log INFO ".gitignore already configured (skipping)"
else
    log INFO "Adding dots repo folder to .gitignore"
    echo ".cfg" >> "${HOME}/.gitignore"
fi

# Clone repo if not exists
if [[ -d "$DOTS_DIR" ]]; then
    log INFO "Dots repo already exists (skipping)"
else
    log INFO "Cloning dots repo"
    git clone --bare "$DOTS_REPO" "$DOTS_DIR"

    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

    log INFO "Checking out dots repo"
    config checkout
fi

log INFO "Init completed"
log INFO "Make sure to source ${shell_config}"
