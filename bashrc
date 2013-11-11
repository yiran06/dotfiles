# auth/creds
if [ -f $HOME/.auth.sh ]; then
    source $HOME/.auth.sh
fi

# com specific config
if [ -f $HOME/.comrc.sh ]; then
    source $HOME/.comrc.sh
fi

# private specific config
if [ -f $HOME/.privaterc ]; then
   source $HOME/.privaterc
fi


# export HISTSIZE=100000
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1



# prefer usr/local
export PATH=/usr/local/share:/usr/local/bin:/usr/local/sbin:$PATH
unamestr=`uname`
export TERM=xterm-256color

if [[ "$unamestr" == 'Linux' ]]; then
    alias ack="ack-grep"
    alias gimme="sudo apt-get install"
    alias isthere="apt-cache search"
    alias updateme="sudo apt-get update"
    alias upgrademe="sudo apt-get upgrade"

    alias jslint='~/.npm/jslint/0.2.0/package/bin/jslint.js'

    # if I have a local pip install, add it to path
    if [ -d "$HOME/.local/bin" ]; then
        PATH="$HOME/.local/bin:$PATH"
    fi

    if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
        source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
    fi
    source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh


elif [[ "$unamestr" == 'Darwin' ]]; then
    # alias vim="mvim -v"
    if [ -f `brew --prefix`/etc/profile.d/z.sh ]; then
       . `brew --prefix`/etc/profile.d/z.sh
    fi
    alias gimme="brew install"
    alias isthere="brew search"
    alias updateme="brew update"
    alias upgrademe="brew upgrade"
    export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk

    # export MACOSX_DEPLOYMENT_TARGET=10.8
    if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
    fi

    # z
    if [ -f `brew --prefix`/etc/profile.d/z.sh ]; then
    . `brew --prefix`/etc/profile.d/z.sh
    fi
    # aws/ec2 specific tools
    # export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
    export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.3-62308/jars"

    # if I have a local pip install, add it to path
    # if [ -d "$HOME/Library/Python/2.7/bin" ]; then
    #     PATH="$HOME/Library/Python/2.7/bin:$PATH"
    # fi

    if [ -f /Library/Python/2.7/site-packages/powerline/bindings/bash/powerline.sh ] && [ -n "$TMUX"  ]; then
        source /Library/Python/2.7/site-packages/powerline/bindings/bash/powerline.sh
    fi

fi

alias serve="python -m SimpleHTTPServer 9040"

alias munit="haxelib run munit"
alias mlib="haxelib run mlib"

authme(){ ssh-keygen -t rsa -C "$@"; }
authmeonserver(){ ssh $@ "echo `cat ~/.ssh/id_rsa.pub` >> ~/.ssh/authorized_keys"; }
authtoclipboard(){ pbcopy < ~/.ssh/id_rsa.pub; }



# virtualenv
# export PATH=$HOME/.venv_bootstrap/bin:$PATH
# export WORKON_HOME=$HOME/.virtualenvs
# source virtualenvwrapper_lazy.sh

# export CLICOLOR=1
# export LSCOLORS=GxFxCxDxBxegedabagaced
export PATH=$PATH:~/bin
export CVSEDITOR=vim
export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim

alias ls='ls -G'
alias ll='ls -al'
alias ..='cd ..'
alias p4_untracked='find . -type f -print0 | xargs -0 p4 fstat >/dev/null'
alias cdp="cd -P"
alias ssh='ssh -X'
alias tnuke="killall tmux"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# export HAXE_STD_PATH="/usr/local/lib/haxe/std"

# android
#export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
#export ANDROID_HOME=`brew --prefix android`

#ruby
#export GEM_HOME=$HOME/.gems
#export GEM_PATH=$HOME/.gems:/usr/lib/ruby/gems/1.8/
#export PATH=$PATH:$HOME/.gems/bin
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# hadoop
export HADOOP_OPTS="-Djava.security.krb5.realm=OX.AC.UK -Djava.security.krb5.kdc=kdc0.ox.ac.uk:kdc1.ox.ac.uk"

# node.js
export NODE_PATH="/usr/local/lib/node"
export NODE_PATH="/usr/local/lib/node_modules":$NODE_PATH # node modules
export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH # jsctags
export PATH=/usr/local/share/npm/bin:$PATH # npm
export PKG_CONFIG_PATH # ?

# java
export JAVA_OPTS=-Xmx2500m


# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8

# append to history
shopt -s histappend


