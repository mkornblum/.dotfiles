# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="re5et"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

alias scp='scp -r'
alias l.='l ./*(.)'
alias l/='l -d ./*(/)'
alias lm='l --sort time -r'
alias lc='l | wc -l'

alias gp='ps aux | grep'
#alias gk='grepkill'

alias be='bundle exec'
alias rake='be rake'
alias rc='be rails c'
alias rdbc='be rails dbconsole'
alias rs='be rails s'
alias rg='be rails g'

alias mongod="mongod run --config /usr/local/Cellar/mongodb/2.0.2-x86_64/mongod.conf"
alias pg_start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg_stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

alias redis_start='redis-server /usr/local/etc/redis.conf'
alias htop='sudo htop'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.

umask 022

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ $EMACS = t ]] && unsetopt zle

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

eval "$(direnv hook zsh)"
