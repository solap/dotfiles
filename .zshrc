# Disable history expansion
set +H

# =============================================================================
#                                   PATH CONFIGURATION
# =============================================================================
typeset -U path  # Ensure unique entries
path=(
    /opt/homebrew/bin
    /Applications/Cursor.app/Contents/MacOS
    /usr/local/bin
    /usr/local/sbin
    /usr/local/heroku/bin
    "$HOME/.rvm/bin"
    /usr/local/share/npm/bin
    /usr/bin
    /usr/sbin
    /bin
    /sbin
    $path
)

# =============================================================================
#                               COMPLETION
# =============================================================================
# Initialize completion
autoload -Uz compinit
compinit

# Completion settings
zstyle ':completion:*' menu select  # Menu-style completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case-insensitive completion

# =============================================================================
#                               OH-MY-ZSH SETTINGS
# =============================================================================
# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation
ZSH=$HOME/.oh-my-zsh

# Theme configuration
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
    git
    macos
    docker
    brew
    z
    zsh-autosuggestions    # Suggests commands as you type
    zsh-syntax-highlighting # Syntax highlighting in terminal
    colored-man-pages      # Colorful man pages
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Rest of the configuration remains the same...