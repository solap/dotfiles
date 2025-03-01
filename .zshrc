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
# Powerlevel10k instant prompt (keep this at the top of oh-my-zsh section)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH=$HOME/.oh-my-zsh
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

# =============================================================================
#                           ELIXIR AND PHOENIX
# =============================================================================
function killbeam_port() {
    lsof -i tcp:$1 | grep beam | awk 'NR!=1 {print $2}' | xargs kill -9
}

# Start Phoenix server in interactive mode
alias phx='iex -S mix phx.server'
alias phxs='clear && mix phx.server'  # Start Phoenix server
alias phxi='clear && iex -S mix'      # Start interactive Elixir shell
alias psetup='mix deps.get && mix ecto.setup'

# =============================================================================
#                           POSTGRESQL
# =============================================================================
alias pgstart='brew services start postgresql'
alias pgstop='brew services stop postgresql'
alias pgrestart='brew services restart postgresql'
alias pgconnect='psql postgres'
alias pglist='psql -l'

pgcreate() { psql -c "CREATE DATABASE $1;" }
pgdrop() { psql -c "DROP DATABASE IF EXISTS $1;" }
pgdb() { psql -d "$1" }
pgbackup() { pg_dump "$1" > "$1_backup_$(date +%Y%m%d_%H%M%S).sql" }
pgrestore() { psql -d "$1" -f "$2" }

# =============================================================================
#                           P10K CUSTOMIZATION
# =============================================================================
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh