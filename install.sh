#!/bin/bash

# Get the directory where the script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh is already installed."
fi

# Install Oh My Zsh plugins
echo "Installing Oh My Zsh plugins..."
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
  echo "zsh-autosuggestions already installed."
fi

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting already installed."
fi

# Install Powerlevel10k theme (optional)
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  echo "To use Powerlevel10k, set ZSH_THEME=\"powerlevel10k/powerlevel10k\" in your .zshrc"
else
  echo "Powerlevel10k theme already installed."
fi

# Create symbolic links for all dotfiles
echo "Creating symbolic links for dotfiles..."
# Backup existing dotfiles first
mkdir -p "$HOME/.dotfiles_backup"
for file in .aliases .bash_profile .bash_prompt .exports .functions .tmux.conf .zaliases .zshrc; do
  if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
    echo "Backing up existing $file to ~/.dotfiles_backup/"
    cp "$HOME/$file" "$HOME/.dotfiles_backup/"
  fi
done

ln -sf "$DOTFILES_DIR/.aliases" ~/.aliases
ln -sf "$DOTFILES_DIR/.bash_profile" ~/.bash_profile
ln -sf "$DOTFILES_DIR/.bash_prompt" ~/.bash_prompt
ln -sf "$DOTFILES_DIR/.exports" ~/.exports
ln -sf "$DOTFILES_DIR/.functions" ~/.functions
ln -sf "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES_DIR/.zaliases" ~/.zaliases
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc

# Make sure .zshrc sources the additional files
if ! grep -q "source ~/.zaliases" "$DOTFILES_DIR/.zshrc"; then
  echo "Adding source for .zaliases to .zshrc"
  echo "# Source zaliases file" >> "$DOTFILES_DIR/.zshrc"
  echo "[ -f ~/.zaliases ] && source ~/.zaliases" >> "$DOTFILES_DIR/.zshrc"
fi

if ! grep -q "source ~/.aliases" "$DOTFILES_DIR/.zshrc"; then
  echo "Adding source for .aliases to .zshrc"
  echo "# Source aliases file" >> "$DOTFILES_DIR/.zshrc"
  echo "[ -f ~/.aliases ] && source ~/.aliases" >> "$DOTFILES_DIR/.zshrc"
fi

# Check for and install common dependencies
if command -v brew &>/dev/null; then
    echo "Homebrew is installed. Installing dependencies..."
    # Install latest zsh
    brew install zsh
    # Add your common dependencies here
    brew install tmux
else
    echo "Homebrew is not installed. Please install it first."
fi

echo "Setup complete!"
echo "Please start a new terminal session or run 'zsh' to load your Zsh configuration."
