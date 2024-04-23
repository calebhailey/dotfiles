# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
      source "$HOME/.bashrc"
    fi;
    if [ -f "$HOME/.bash_aliases" ]; then
      source "$HOME/.bash_aliases"
    fi;
fi;

# add local/user bin directories to $PATH
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi;
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi;

# if Golang binaries are installed, add them to $PATH
if [ -d "/usr/local/go" ]; then
    GOPATH="$HOME/go"
    PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
fi;

# if Python packages are installed, add them to $PATH
if [ $(command -v python3) ]; then
    PYTHON_VERSION=$(python3 --version | cut -d" " -f2 | cut -d"." -f "1 2") 
    PATH="$PATH:$HOME/Library/Python/${PYTHON_VERSION}/bin"
fi;

# if Bun binaries are installed, add them to $PATH
if [ -d "$HOME/.bun" ]; then
    BUN_INSTALL="$HOME/.bun" 
    PATH="$PATH:$BUN_INSTALL/bin" 
fi;

# if Google Cloud SDK is installed, add it to the $PATH
if [ -d "/usr/local/google-cloud-sdk/" ]; then
    PATH="$PATH:/usr/local/google-cloud-sdk/bin"
fi;

# ssh keys
eval "$(ssh-agent -s)" > /dev/null
for KEY in $(ls $HOME/.ssh/* 2> /dev/null)
do
  if ( file $KEY | grep -iq "OpenSSH private" ); then 
    ssh-add $KEY &> /dev/null 
    echo "Identity added: $(basename ${KEY})"
  elif ( file $KEY | grep -iq "PEM RSA" ); then
    ssh-add $KEY &> /dev/null
    echo "Identity added: $(basename ${KEY})"
  fi
done;

# use direnv
if [ "$(which direnv)" ]; then
    eval "$(direnv hook bash)"
fi;

# secrets
if [ -e "$HOME/.bash_secrets" ]; then
  . "$HOME/.bash_secrets"
fi;

# prompt
case $(uname -s) in
  Darwin)
    HOSTNICKNAME=$(hostname | cut -d'.' -f1)
    export PS1="\[\e[1;32m\]${HOSTNICKNAME} \[\e[m\]\\$ "
    ;;
  Linux)
    if [ "$(hostname)" == "penguin" ]; then
      export PS1="\[\e[1;32m\]pixelbook \[\e[m\]\\$ "
    elif [ -f /run/.containerenv ]; then
      export PS1="\[\e[1;32m\]workstation \[\e[m\]\\$ "
    else
      export PS1="\[\e[1;32m\]$(hostname) \[\e[m\]\\$ "
    fi
    ;;
  *)
    export PS1="\[\e[1;32m\]computer \[\e[m\]\\$ "
    ;;
esac;

# docker remote API
# https://success.docker.com/article/how-do-i-enable-the-remote-api-for-dockerd
if [ "$(curl --no-buffer -XGET -s -I -f http://127.0.0.1:2376/containers/json)" ]; then 
    export DOCKER_HOST="tcp://127.0.0.1:2376"
fi;

# sensuctl completion!
if [ $(which sensuctl) ]; then
  source <(sensuctl completion bash)
fi;

# ignore MacOS zsh reminder 
export BASH_SILENCE_DEPRECATION_WARNING=1

# rejoin active tmux sessions 
if [ $(which tmux) ]; then
  if [ !$(tmux list-sessions > /dev/null 2>&1) ] && [ -z $TMUX ]; then 
    tmux attach -d
  fi;
fi;

