#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
export BROWSER=firefox.desktop
export EDITOR=/usr/bin/vim
export VISUAL="$EDITOR"
export TERM=xterm-256color
export PAGER=less

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
#export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput sgr0)\]\[$(tput setaf 5)\]\[$(tput sitm)\]\w\[$(tput sgr0)\]\[$(tput bold)\]\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# Modify PATH
export PATH=${PATH}:/home/${USER}/bin:$HOME/go/bin:$HOME/.config/composer/vendor/bin:/home/david/.gem/ruby/2.5.0/bin:${HOME}/.local/bin

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
export HISTIGNORE='pwd:jobs:ll:ls:l:fg:history:clear:exit'

# default editor for kubectl
export KUBE_EDITOR=/usr/bin/vim

# Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Wasmer
export WASMER_DIR="$HOME/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"  # This loads wasmer

complete -C /usr/bin/terraform terraform

# Intellij fix
# https://stackoverflow.com/a/34419927/7733616
export _JAVA_AWT_WM_NONREPARENTING=1

# Diff colors
alias diff='diff | diff-so-fancy'

alias k=kubectl

# SSH key fun
alias ssh-pigeon='ssh-add -D && ssh-add ~/.ssh/pigeon'
alias ssh-polaris_rsa='ssh-add -D && ssh-add ~/.ssh/polaris_rsa'
