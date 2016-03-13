# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#Setup Path variable 
for p in \
    /home/benpeters/bin \
    /usr/local/bin \
    /usr/local/sbin \
    /opt/local/bin \
    /opt/local/sbin \
    /usr/local/mysql/bin \
    ; do
    [ -x $p ] && PATH=$p:$PATH
done
unset p
export PATH=${PATH##:}:.

# User specific aliases and functions
#Shortcuts
alias la='ls -A'
alias ll='ls -lsah'
function cdl { cd $1; ls;}
alias rm='rm -i'
alias mv='mv -i'
alias vimm='vim -O2'
alias v='vim'
alias ..='cd ..'
alias gr='grep -rn'

#git auto-complete
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi
#git aliases
alias g='git'
complete -F _git g
__git_shortcut gs status
__git_shortcut gc commit -m
__git_shortcut ga add
__git_shortcut gca commit -a -m
__git_shortcut gco checkout
__git_shortcut gm merge --no-ff
__git_shortcut gl log
__git_shortcut gb branch
__git_shortcut gbr branch -r
__git_shortcut gpu push
__git_shortcut gpl pull

set -o vi

# setup git prompt if possible (set default first)
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1='\[\033[1G\e[33m\]\u@\h\[\e[0m\].\[\033[32m\]\W\[\033[31m\]$(parse_git_branch)\[\033[0m\] \$ '

stty stop undef # to unmap ctrl-s

complete -C aws_completer aws

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# added by Miniconda 3.8.3 installer
alias activate_miniconda='export PATH="/Users/benpeters/miniconda/bin:$PATH"'
ulimit -S -n 2048

alias screen=/usr/local/bin/screen

alias reset_docker_dns='docker-machine ssh $(docker-machine active) "sudo udhcpc SIGUSR1 && sudo /etc/init.d/docker restart"'
export NVM_DIR=~/.nvm
source /usr/local/opt/nvm/nvm.sh
