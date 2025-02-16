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
ZSH_THEME="theunraveler"

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
#                               VI MODE SETTINGS
# =============================================================================
bindkey -v
export KEYTIMEOUT=1

# Vi mode with better indicators
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%}[NORMAL]%{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

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
export VISUAL="vim"
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
# Add this to your .zshrc
function ...() {
    cd ../..
}
alias ..='cd ..'
# Alternative approach
alias cdd='cd ../..'
alias cddd='cd ../../..'
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
#                           GIT STUFF
# =============================================================================

# Add these to your theme or create a custom theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"


# =============================================================================
#                           FUN STUFF
# =============================================================================

# Weather in terminal
alias weather='curl wttr.in'

# Matrix-like screen effect
alias matrix='echo -e "\e[32m"; while :; do for i in {1..16}; do r="$(($RANDOM % 2))"; if [[ $(($RANDOM % 5)) == 1 ]]; then if [[ $(($RANDOM % 4)) == 1 ]]; then v+="\e[1m $r   "; else v+="\e[2m $r   "; fi; else v+="     "; fi; done; echo -e "$v"; v=""; done'

# Resource usage in a more readable format
alias cpu='top -o cpu'
alias mem='top -o rsize'

# Quick timer
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Pipes variations
alias pipes='pipes.sh'                    # Default pipes
alias pipeselbow='pipes.sh -t 1'             # Elbow pipes
alias pipestracks='pipes.sh -t 2'             # Railway tracks
alias pipesmaze='pipes.sh -t 3'             # Maze style
alias pipesfast='pipes.sh -r 0.1'        # Fast animation
alias pipesslow='pipes.sh -r 0.5'        # Slow animation
alias pipesmany='pipes.sh -p 10'         # Lots of pipes
alias pipesfew='pipes.sh -p 3'           # Just a few pipes
alias pipescolor='pipes.sh -c 1 -c 2 -c 3 -c 4 -c 5 -c 6 -c 7' # Rainbow colors

# Get a random quote
alias quote='curl -s https://api.quotable.io/random | jq -r ".content + \"\n  -- \" + .author"'

# Busy programmer simulator
alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'"

# Train simulator
alias sl='sl -a'  # Requires installing sl package

# Fortune cookie
alias fortune='fortune | cowsay'  # Requires fortune and cowsay packages

# Parrot party! (requires terminal-parrot)
alias parrot='curl parrot.live'



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