# bash completion!
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi


export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

alias ls='ls -G'
alias ll='ls -al'
alias ..='cd ..'


# personal scripts
export PATH=$HOME/bin/datatools:$HOME/bin:/usr/local/haxe/bin:$PATH

# prefer usr/local
export PATH=/usr/local/bin:$PATH

function setdsm() { 
    export PYTHONPATH=$PYTHONPATH:$PWD/..
    export PYTHONPATH=$PYTHONPATH:$PWD
    if [ -z "$1" ]; then
        x=${PWD/\/[^\/]*\/}
        export DJANGO_SETTINGS_MODULE=$x.settings
    else
        export DJANGO_SETTINGS_MODULE=$1
    fi
    
    echo "DJANGO_SETTINGS_MODULE set to $DJANGO_SETTINGS_MODULE"
}



function parse_git_dirty {
   [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

export PS1="\[\e[01;32m\]\h \[\e[01;34m\]\W \$(parse_git_branch)\[\e[01;34m\]$\[\e[00m\] "

export NODE_PATH="/usr/local/lib/node"
export PKG_CONFIG_PATH
export LSCOLORS="gxfxcxdxbxegedabagacad"
export CVSEDITOR=emacs
export EDITOR=emacs
export JAVA_OPTS=-Xmx2500m
export SVN_EDITOR=emacs
export GIT_EDITOR=emacs
# ML=~/Projects/BigML/

# haxe specific path/env mods

export HAXE_LIBRARY_PATH=/usr/lib/haxe/std:. # the ':.' part is important
export HAXE_HOME=/usr/lib/haxe
PATH=$PATH:$HAXE_LIBRARY_PATH:$HAXE_HOME/bin

#prefer local path
PATH=/usr/local/bin:$PATH

#AWS/EC2 specific tools
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.3-62308/jars"

# rvm for managing ruby
# if [[ -s /Users/jjdonald/.rvm/scripts/rvm ]] ; then source /Users/jjdonald/.rvm/scripts/rvm ; fi


