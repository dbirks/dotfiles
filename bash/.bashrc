#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR
export TERM=xterm-256color

# Xrandr
#xrandr --output DP1 --mode 1920x1080
#xrdb -merge ~/.Xresources

# NVM
export NVM_DIR="/home/david/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# locale exports
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# start ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > /tmp/ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(</tmp/ssh-agent-thing)" >/dev/null
fi

# Custom bash prompt via kirsle.net/wizards/ps1.html
# Rainbow scheme
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# Modify PATH
export PATH=${PATH}:/home/${USER}/bin:/home/${USER}/bin/go:$HOME/.config/composer/vendor/bin:/home/david/.gem/ruby/2.5.0/bin

# Golang
#export GOPATH=/home/${USER}/bin/go

# alias for https://transfer.sh
transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

# save bash history, and also append it after every command
shopt -s histappend
export PROMPT_COMMAND="history -a; history -n"

# set Bash history to unlimited
export HISTSIZE=-1
export HISTFILESIZE=-1

# default editor for kubectl
export KUBE_EDITOR=/usr/bin/vim

# git docker container
function git4 () {
    (docker run -ti --rm -e GIT_DISCOVERY_ACROSS_FILESYSTEM=1 -v ${HOME}:/root -v $(pwd):/git alpine/git "$@")
}

got(){
    docker run -it --rm -v ${HOME}:/home/git-user -v ${PWD}:/git-workdir -e UID=$UID -e GID=$GROUPS -e GIT_DISCOVERY_ACROSS_FILESYSTEM db378/git "$@"
}

