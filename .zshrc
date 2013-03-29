# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
# ZSH_THEME="random"
ZSH_THEME="theunraveler"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx ruby rails)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# export PATH=/usr/local/heroku/bin:/Users/tadd.giles/.rvm/gems/ruby-1.9.3-p392@global/bin:/Users/tadd.giles/.rvm/rubies/ruby-1.9.3-p392/bin:/Users/tadd.giles/.rvm/bin:/usr/local/bin:/usr/local/sbin:/Users/tadd.giles/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
export PATH=/usr/local/heroku/bin:$HOME/.rvm/bin:/usr/local/share/npm/bin:$PATH

export EDITOR="vim"
bindkey -v

bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# Load additional files
# ~/.zextras can be used for settings you don’t want to commit
for file in ~/.{zextras,zaliases}; do
	[ -r "$file" ] && source "$file"
done
unset file

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

__rvm_project_rvmrc
