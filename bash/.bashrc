#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
export BROWSER=firefox
export EDITOR=vim
export VISUAL="$EDITOR"
export TERM=xterm-256color
#export TERM=screen-256color-bce
export PAGER=less
[ -n "$TMUX" ] && export TERM=screen-256color
export PATH=$PATH:~/.local/bin/

# locale exports
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# # start ssh-agent
# if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#     ssh-agent > /tmp/ssh-agent-thing
# fi
# if [[ "$SSH_AGENT_PID" == "" ]]; then
#     eval "$(</tmp/ssh-agent-thing)" >/dev/null
# fi

# Custom bash prompt via kirsle.net/wizards/ps1.html
# Rainbow scheme
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput sgr0)\]\[$(tput setaf 5)\]\[$(tput sitm)\]\w\[$(tput sgr0)\]\[$(tput bold)\]\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# save bash history, and also append it after every command
shopt -s histappend
export PROMPT_COMMAND="history -a; history -n"

# set Bash history to unlimited
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTIGNORE='pwd:jobs:ll:ls:l:fg:history:clear:exit'

# Kubernetes
export KUBE_EDITOR=$EDITOR

# Intellij fix
# https://stackoverflow.com/a/34419927/7733616
export _JAVA_AWT_WM_NONREPARENTING=1

# Diff colors
alias diff='diff | diff-so-fancy'

# Functions to decode JWT tokens
# https://gist.github.com/thomasdarimont/46358bc8167fce059d83a1ebdb92b0e7
decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'='
  fi
  echo "$result" | tr '_-' '/+' | openssl enc -d -base64
}

decode_jwt(){
   decode_base64_url $(echo -n $2 | cut -d "." -f $1) | jq .
}

# Decode JWT header
alias jwth="decode_jwt 1"

# Decode JWT Payload
alias jwtp="decode_jwt 2"

# Serverless autocompletion
[ -r /usr/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
[ -r /usr/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash

export-aws-creds() {
  # AWS creds to environment
  export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
  export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)
  export AWS_DEFAULT_REGION=$(aws configure get region)
}

unset-aws-creds() {
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_DEFAULT_REGION
}

# consoledonottrack.com
export DO_NOT_TRACK=1

# Show postgres error colors
export PG_COLOR=always

# https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity#Tools_for_generating_SRI_hashes
generate-sha256-sri-hash-from-url() {
  curl -L $1 | shasum -b -a 256 | awk '{ print $1 }' | xxd -r -p | base64 | awk '{ print "sha256-" $1 }'
}

add-nixpkgs-remote() {
  git remote add $1 git@github.com:$1/nixpkgs.git
  git fetch $1
}

backup-s3-bucket() {
  mkdir $1
  cd $1
  aws s3 sync s3://$1 .
  cd -
}

login-to-ecr() {
  local REGION=$(aws configure get region)
  local ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

  aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
}

