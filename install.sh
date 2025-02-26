#!/bin/bash

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh is already installed."
fi

# Get the directory where the script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create symbolic links for all dotfiles
ln -sf "$DOTFILES_DIR/.aliases" "$HOME/.aliases"
ln -sf "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"
ln -sf "$DOTFILES_DIR/.bash_prompt" "$HOME/.bash_prompt"
ln -sf "$DOTFILES_DIR/.exports" "$HOME/.exports"
ln -sf "$DOTFILES_DIR/.functions" "$HOME/.functions"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/.zaliases" "$HOME/.zaliases"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Source configuration for current session (using zsh)
echo "Dotfiles installed! Sourcing .zshrc..."
zsh -c "source ~/.zshrc"

# Check for and install common dependencies
if command -v brew &>/dev/null; then
    echo "Homebrew is installed. Installing dependencies..."
    # Add your common dependencies here
    brew install tmux
else
    echo "Homebrew is not installed. Please install it first."
fi

echo "Setup complete!"
echo "Please start a new terminal session to load your Zsh configuration."
