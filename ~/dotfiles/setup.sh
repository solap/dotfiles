#!/bin/bash

# Script to set up dotfiles symlinks and configurations

# Set up colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "Setting up dotfiles..."

# Create backup directory
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to backup and symlink
setup_symlink() {
    local source="$1"
    local target="$2"
    
    # If the target file exists and is not a symlink
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up existing $target to $BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
    fi

    # Create the symlink
    if [ ! -e "$target" ]; then
        ln -sf "$source" "$target"
        echo -e "${GREEN}Created symlink for $target${NC}"
    else
        echo -e "${RED}$target already exists${NC}"
    fi
}

# Set up symlinks
setup_symlink "$PWD/.zshrc" "$HOME/.zshrc"
# Add any other dotfiles you want to manage:
# setup_symlink "$PWD/.gitconfig" "$HOME/.gitconfig"
# setup_symlink "$PWD/.p10k.zsh" "$HOME/.p10k.zsh"

# Source the new configuration
echo "Sourcing new configuration..."
source "$HOME/.zshrc"

echo -e "${GREEN}Dotfiles setup complete!${NC}" 