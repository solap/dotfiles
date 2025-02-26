# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# =============================================================================
#                               HISTORY SETTINGS
# =============================================================================
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS  # Don't record duplicates
setopt HIST_SAVE_NO_DUPS     # Don't save duplicates
setopt HIST_REDUCE_BLANKS    # Remove blank lines
setopt INC_APPEND_HISTORY    # Add commands as they are typed
setopt EXTENDED_HISTORY      # Add timestamps to history

# =============================================================================
#                           DIRECTORY NAVIGATION
# =============================================================================
setopt AUTO_CD              # Just type directory name to cd
setopt AUTO_PUSHD          # Push dir to stack automatically
setopt PUSHD_IGNORE_DUPS   # Don't push duplicates
setopt PUSHD_SILENT        # Don't print stack after push/pop

# =============================================================================
#                           SYSTEM
# =============================================================================
# Confirm before overwriting
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Prevent accidental deletion of root
alias rm='rm --preserve-root'

# =============================================================================
#                               KEY BINDINGS
# =============================================================================
# History search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# Ensure proper key bindings for completion
bindkey '^I' complete-word        # tab to complete
bindkey '^[[Z' reverse-menu-complete  # shift-tab to reverse complete

# =============================================================================
#                           ENVIRONMENT VARIABLES
# =============================================================================
export VISUAL="nano"
export EDITOR="$VISUAL"
export PAGER="less"
export LESS="-R"  # Allow colors in less
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Larger node memory limit for development
export NODE_OPTIONS="--max-old-space-size=4096"
# Better Python development
export PYTHONDONTWRITEBYTECODE=1  # Prevent __pycache__ directories
export VIRTUAL_ENV_DISABLE_PROMPT=1  # Handle virtual env prompt manually

# =============================================================================
#                                   ALIASES
# =============================================================================
# List directories
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias projects='cd ~/projects'
alias docs='cd ~/Documents'
alias dev='cd ~/Development'
alias dl='cd ~/Downloads'
alias c='clear'

# Applications
alias cursor='open -a "Cursor"'

# Quick access to config files
alias zshrc='$EDITOR ~/.zshrc'
alias src='source ~/.zshrc'

# Copy with progress bar
alias cpv='rsync -ah --info=progress2'

# Resource usage in a more readable format
alias cpu='top -o cpu'
alias mem='top -o rsize'

# Weather in terminal (useful utility to keep)
alias weather='curl wttr.in'

# =============================================================================
#                           ADDITIONAL CONFIGS
# =============================================================================
# Load additional configuration files
for file in ~/.zsh.d/*.zsh(N); do
    source "$file"
done

# Load extra files (if they exist)
for file in ~/.{zextras,zaliases}; do
    [ -r "$file" ] && source "$file"
done
unset file

# =============================================================================
#                           ELIXIR AND PHOENIX
# =============================================================================
function killbeam_port() {
    lsof -i tcp:$1 | grep beam | awk 'NR!=1 {print $2}' | xargs kill -9
}

# Start Phoenix server in interactive mode
alias phx='iex -S mix phx.server'

# Start Phoenix runtime without server
alias phxc='mix run'

# Project setup (get dependencies and setup database)
alias psetup='mix deps.get && mix ecto.setup'

# Additional helpful Phoenix aliases
alias phxs='clear && mix phx.server'  # Start Phoenix server
alias phxi='clear && iex -S mix'      # Start interactive Elixir shell with project context

# =============================================================================
#                           POSTGRESQL
# =============================================================================
# Start PostgreSQL service
alias pgstart='brew services start postgresql'

# Stop PostgreSQL service
alias pgstop='brew services stop postgresql'

# Restart PostgreSQL service
alias pgrestart='brew services restart postgresql'

# Connect to PostgreSQL as default user
alias pgconnect='psql postgres'

# List all PostgreSQL databases
alias pglist='psql -l'

# Create a new database
pgcreate() {
    psql -c "CREATE DATABASE $1;"
}

# Drop a database
pgdrop() {
    psql -c "DROP DATABASE IF EXISTS $1;"
}

# Connect to a specific database
pgdb() {
    psql -d "$1"
}

# Backup a database
pgbackup() {
    pg_dump "$1" > "$1_backup_$(date +%Y%m%d_%H%M%S).sql"
}

# Restore a database from a backup
pgrestore() {
    psql -d "$1" -f "$2"
}

# Function to update all development tools
function update_all() {
  echo "Updating Homebrew packages..."
  brew update && brew upgrade
  echo "Updating Oh My Zsh..."
  omz update
  echo "All updates complete!"
}
alias upall='update_all'

# Load fzf if installed
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
