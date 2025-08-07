# ~/.bashrc — Final Modular + Advanced Dev Setup

[[ $- != *i* ]] && return  # Skip if not interactive shell

############### Colors ###################
BLACK="\[\033[0;38m\]"
RED="\[\033[0;31m\]"
RED_BOLD="\[\033[01;31m\]"
BLUE="\[\033[01;34m\]"
GREEN="\[\033[0;32m\]"

############### VCS Functions ############
parse_git_branch () {
  git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)# (git::\1)#'
}
parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk '{print " (svn::"$1")" }'
}
parse_svn_url() {
  svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
  svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}
svndiff() {
  svn diff "${@}" | colordiff
}

############### Prompt ###################
export PS1="$BLACK[\u@$RED\h $GREEN\W$RED_BOLD\$(parse_git_branch)\$(parse_svn_branch)$BLACK] "
export TERM='xterm-256color'
export SHELL='/bin/bash'

############### Load Aliases #############
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_aliases_git ] && . ~/.bash_aliases_git
[ -f ~/.bash_aliases_drupal ] && . ~/.bash_aliases_drupal
[ -f ~/.bash_aliases_docker ] && . ~/.bash_aliases_docker
[ -f ~/.bashoverride ] && . ~/.bashoverride

############### History & Editor #########
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTTIMEFORMAT='%F %T '
export EDITOR=vim

############### SSH Agent ################
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent -s)
fi

############### AWS CLI Completion #######
AWS_COMPLETER=$(which aws_completer 2>/dev/null)
if [[ $? -eq 0 ]]; then
    export PATH=$PATH:$(dirname "$AWS_COMPLETER")
    complete -C "$AWS_COMPLETER" aws
fi

############### RVM, rbenv, jenv #########
if [ -d "$HOME/.rbenv" ]; then
    PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

if [ -d "$HOME/.jenv" ]; then
    PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
fi

export PATH="$PATH:$HOME/.rvm/bin"

############### Optional Tools ###########
if hash thefuck 2>/dev/null; then
    eval "$(thefuck --alias)"
fi

############### Bash Completion ##########
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

