# ~/.dotfiles/.bash_aliases
# sourced by both .zshrc and .bashrc, so keep it bash compatible

alias _='sudo'

# paths and dirs
alias ..='cd ..'
alias ....='cd ../..'
alias dirs="dirs -v"                  # default to vert, use -l for list

# function-type aliases
alias publicip="curl icanhazip.com"

# default flags for programs
alias vi="vim"
alias vim="vim"                    # open in tabs by default
alias wget="wget --no-check-certificate"
alias rsync="rsync --exclude-from=$HOME/.cvsignore"

# tmux
alias remux="if tmux has 2>/dev/null; then tmux attach; else tmux new $SHELL; fi"
alias demux="tmux detach"

# quick edits
alias vimrc="vim ~/.vimrc"
alias gvimrc="vim ~/.gvimrc"
alias aliases="vim ~/.dotfiles/bash/.bash_aliases"
alias zshrc="vim ~/.zshrc"
alias zshenv="vim ~/.zshenv"
alias lzshrc="vim ~/.zshrc.local"
alias lzshenv="vim ~/.zshenv.local"
alias bashrc="vim ~/.bashrc"
alias lbashrc="vim ~/.bashrc.local"
alias hosts="vim /etc/hosts"
alias phpini="vim $PHP_INI"
alias apacheconf="vim $APACHE_HOME/conf/httpd.conf"
alias vhosts="vim $APACHE_HOME/conf/extra/httpd-vhosts.conf"

# apache
alias apache2ctl="sudo $APACHE_HOME/bin/apachectl"
alias apacheerrors="tail $APACHE_HOME/logs/error_log"
